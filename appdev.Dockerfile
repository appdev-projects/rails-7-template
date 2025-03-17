FROM ubuntu:focal

### base ###
ENV DEBIAN_FRONTEND=noninteractive LANG=en_US.UTF-8
RUN yes | unminimize \
    && apt-get install -yq \
        curl \
        wget \
        acl \
        zip \
        unzip \
        bash-completion \
        build-essential \
        jq \
        locales \
        software-properties-common \
        libpq-dev \
        sudo \
        git \
        graphviz=2.42.2-3build2 \
        psmisc \
        redis-server=5:5.0.7-2ubuntu0.1 \
    && locale-gen en_US.UTF-8 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* \
    # Container user
    # '-l': see https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
    && useradd -l -u 33334 -G sudo -md /home/student -s /bin/bash -p student student \
    # Passwordless sudo for users in the 'sudo' group
    && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
ENV HOME=/home/student

### Student user ###
USER student
# Use sudo so that user does not get sudo usage info on (the first) login
RUN sudo mkdir -p $HOME \
    && sudo echo "Running 'sudo' for container: success" && \
    # Create .bashrc.d folder and source it in the bashrc
    mkdir /home/student/.bashrc.d && \
    (echo; echo "for i in \$(ls \$HOME/.bashrc.d/*); do source \$i; done"; echo) >> /home/student/.bashrc \
    # Install Ruby with RVM
    && curl -sSL https://rvm.io/mpapis.asc | gpg --import - \
    && curl -sSL https://rvm.io/pkuczynski.asc | gpg --import - \
    && curl -fsSL https://get.rvm.io | bash -s stable \
    && bash -lc " \
        rvm requirements \
        && rvm install 3.2.1 \
        && rvm use 3.2.1 --default \
        && rvm rubygems current \
        && gem install bundler:2.4.6 --no-document" \
    && echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*' >> /home/student/.bashrc.d/70-ruby && echo "rvm_gems_path=/home/student/.rvm" > ~/.rvmrc

ENV GEM_HOME=/workspaces/.rvm PATH=/workspaces/.rvm/bin:$PATH

WORKDIR /rails-template

# Pre-install gems into /rails-template/gems/
COPY --chown=student:student Gemfile Gemfile.lock /rails-template/
RUN /bin/bash -l -c "bundle install" \
    # Install postgresql 16
    && sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt `lsb_release -cs`-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - \
    && sudo apt-get update \
    && sudo apt-get install -y postgresql-16 postgresql-contrib-16

# Setup PostgreSQL configuration
ENV PATH="$PATH:/usr/lib/postgresql/16/bin" PGDATA="/workspaces/.pgsql/data"
RUN sudo mkdir -p $PGDATA \
    && mkdir -p ~/.pg_ctl/bin ~/.pg_ctl/sockets \
    && printf '#!/bin/bash\n[ ! -d $PGDATA ] && mkdir -p $PGDATA && initdb -D $PGDATA\npg_ctl -D $PGDATA -l ~/.pg_ctl/log -o "-k ~/.pg_ctl/sockets" start\n' > ~/.pg_ctl/bin/pg_start \
    && printf '#!/bin/bash\npg_ctl -D $PGDATA -l ~/.pg_ctl/log -o "-k ~/.pg_ctl/sockets" stop\n' > ~/.pg_ctl/bin/pg_stop \
    && chmod +x ~/.pg_ctl/bin/* \
    && sudo addgroup dev \
    && sudo adduser student dev \
    && sudo chgrp -R dev $PGDATA \
    && sudo chmod -R 775 $PGDATA \
    && sudo setfacl -dR -m g:staff:rwx $PGDATA \
    && sudo chmod 777 /var/run/postgresql \
    # This is a bit of a hack. At the moment we have no means of starting background
    # tasks from a Dockerfile. This workaround checks, on each bashrc eval, if the
    # PostgreSQL server is running, and if not starts it.
    && printf "\n# Auto-start PostgreSQL server.\n[[ \$(pg_ctl status | grep PID) ]] || pg_start > /dev/null\n" >> ~/.bashrc
ENV PATH="$PATH:$HOME/.pg_ctl/bin" PGHOSTADDR="127.0.0.1" PGDATABASE="postgres"


RUN curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - \
    # Install Node.js and Yarn
    && sudo apt-get install -y nodejs \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
    && sudo apt-get update \
    && sudo apt-get install -y yarn \
    && sudo npm install -g n \
    && sudo n 18 \
    && hash -r \
    && sudo rm -rf /var/lib/apt/lists/* \
    # Add thoughtbot style bash prompt
    &&  sudo wget -qO ./prompt "https://gist.githubusercontent.com/jelaniwoods/7e5db8d72b3dfac257b7eb562cfebf11/raw/af43083d91c0eb1489059a2ad9c39474a34ddbda/thoughtbot-style-prompt" \
    && /bin/bash -l -c "cat ./prompt >> ~/.bashrc" \
    # Set git config
    && git config --global push.default upstream \
    && git config --global merge.ff only \
    && git config --global alias.aa '!git add -A' \
    && git config --global alias.cm '!f(){ git commit -m "${*}"; };f' \
    && git config --global alias.acm '!f(){ git add -A && git commit -am "${*}"; };f' \
    && git config --global alias.as '!git add -A && git stash' \
    && git config --global alias.p 'push' \
    && git config --global alias.sla 'log --oneline --decorate --graph --all' \
    && git config --global alias.co 'checkout' \
    && git config --global alias.cob 'checkout -b' \
    && git config --global --add --bool push.autoSetupRemote true \
    && git config --global core.editor "code --wait" \
    # Add g alias for git status
    && echo "# No arguments: 'git status'\n\
# With arguments: acts like 'git'\n\
g() {\n\
  if [[ \$# > 0 ]]; then\n\
    git \$@\n\
  else\n\
    git status\n\
  fi\n\
}\n# Complete g like git\n\
source /usr/share/bash-completion/completions/git\n\
__git_complete g __git_main" >> ~/.bash_aliases \
    # Add other aliases
    && echo "alias be='bundle exec'" >> ~/.bash_aliases \
    && echo "alias grade='rake grade'" >> ~/.bash_aliases \
    && echo "alias grade:reset_token='rake grade:reset_token'" >> ~/.bash_aliases \
    && echo 'export PATH="$PWD/bin:$PATH"' >> ~/.bashrc \
    && echo "nohup /workspaces/*/bin/postgres-monitor > /dev/null 2>&1 &" >> ~/.bashrc
