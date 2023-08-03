FROM buildpack-deps:focal

### base ###
RUN yes | unminimize \
    && apt-get install -yq \
        acl \
        zip \
        unzip \
        bash-completion \
        build-essential \
        htop \
        jq \
        less \
        locales \
        man-db \
        nano \
        software-properties-common \
        sudo \
        time \
        vim \
        multitail \
        lsof \
    && locale-gen en_US.UTF-8 \
    && mkdir /var/lib/apt/dazzle-marks \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

ENV LANG=en_US.UTF-8

### Git ###
RUN add-apt-repository -y ppa:git-core/ppa \
    && apt-get install -yq git \
    && rm -rf /var/lib/apt/lists/*

### Container user ###
# '-l': see https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
RUN useradd -l -u 33334 -G sudo -md /home/student -s /bin/bash -p student student \
    # passwordless sudo for users in the 'sudo' group
    && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
ENV HOME=/home/student
WORKDIR $HOME
# custom Bash prompt
RUN { echo && echo "PS1='\[\e]0;\u \w\a\]\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] \\\$ '" ; } >> .bashrc

### Student user (2) ###
USER student
# use sudo so that user does not get sudo usage info on (the first) login
RUN sudo echo "Running 'sudo' for container: success" && \
    # create .bashrc.d folder and source it in the bashrc
    mkdir /home/student/.bashrc.d && \
    (echo; echo "for i in \$(ls \$HOME/.bashrc.d/*); do source \$i; done"; echo) >> /home/student/.bashrc

### Ruby ###
LABEL dazzle/layer=lang-ruby
LABEL dazzle/test=tests/lang-ruby.yaml
USER student
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import - \
    && curl -sSL https://rvm.io/pkuczynski.asc | gpg --import - \
    && curl -fsSL https://get.rvm.io | bash -s stable \
    && bash -lc " \
        rvm requirements \
        && rvm install 3.2.1 \
        && rvm use 3.2.1 --default \
        && rvm rubygems current \
        && gem install bundler:2.4.6 --no-document" \
    && echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*' >> /home/student/.bashrc.d/70-ruby
RUN echo "rvm_gems_path=/home/student/.rvm" > ~/.rvmrc

ENV GEM_HOME=/workspaces/.rvm
ENV GEM_PATH=$GEM_HOME:$GEM_PATH
ENV PATH=/workspaces/.rvm/bin:$PATH

USER student

# AppDev stuff
RUN sudo wget -qO /usr/bin/install-packages "https://gist.githubusercontent.com/jelaniwoods/d5cc8157a0de0f449de748f75e2e182e/raw/c45b0f2947975ff7bb53cbddb8a2fe2e6241db8e/install-packages" \
  && sudo chmod 775 /usr/bin/install-packages
RUN /bin/bash -l -c "gem install htmlbeautifier rufo -N"

WORKDIR /rails-template

# Pre-install gems into /rails-template/gems/
COPY Gemfile /rails-template/Gemfile
COPY --chown=student:student Gemfile.lock /rails-template/Gemfile.lock
RUN /bin/bash -l -c "bundle install"

# Install Google Chrome
RUN sudo apt-get update && sudo apt-get install -y libxss1
RUN wget https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_114.0.5735.198-1_amd64.deb && \
    sudo apt-get install -y ./google-chrome-stable_114.0.5735.198-1_amd64.deb

# Install Chromedriver (compatable with Google Chrome version)
#   See https://gerg.dev/2021/06/making-chromedriver-and-chrome-versions-match-in-a-docker-image/
RUN BROWSER_MAJOR=$(google-chrome --version | sed 's/Google Chrome \([0-9]*\).*/\1/g') && \
    wget https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${BROWSER_MAJOR} -O chrome_version && \
    wget https://chromedriver.storage.googleapis.com/`cat chrome_version`/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip && \
    sudo mv chromedriver /usr/local/bin/ && \
    DRIVER_MAJOR=$(chromedriver --version | sed 's/ChromeDriver \([0-9]*\).*/\1/g') && \
    echo "chrome version: $BROWSER_MAJOR" && \
    echo "chromedriver version: $DRIVER_MAJOR" && \
    if [ $BROWSER_MAJOR != $DRIVER_MAJOR ]; then echo "VERSION MISMATCH"; exit 1; fi


# Install PostgreSQL
RUN sudo install-packages postgresql-12 postgresql-contrib-12

# Setup PostgreSQL server for user student
ENV PATH="$PATH:/usr/lib/postgresql/12/bin"
ENV PGDATA="/workspaces/.pgsql/data"
RUN sudo mkdir -p $PGDATA
RUN mkdir -p $PGDATA ~/.pg_ctl/bin ~/.pg_ctl/sockets \
 && printf '#!/bin/bash\n[ ! -d $PGDATA ] && mkdir -p $PGDATA && initdb -D $PGDATA\npg_ctl -D $PGDATA -l ~/.pg_ctl/log -o "-k ~/.pg_ctl/sockets" start\n' > ~/.pg_ctl/bin/pg_start \
 && printf '#!/bin/bash\npg_ctl -D $PGDATA -l ~/.pg_ctl/log -o "-k ~/.pg_ctl/sockets" stop\n' > ~/.pg_ctl/bin/pg_stop \
 && chmod +x ~/.pg_ctl/bin/* \
 && sudo addgroup dev \
 && sudo adduser student dev \
 && sudo chgrp -R dev $PGDATA \
 && sudo chmod -R 775 $PGDATA \
 && sudo setfacl -dR -m g:staff:rwx $PGDATA \
 && sudo chmod 777 /var/run/postgresql
ENV PATH="$PATH:$HOME/.pg_ctl/bin"
# ENV DATABASE_URL="postgresql://student@localhost"
ENV PGHOSTADDR="127.0.0.1"
ENV PGDATABASE="postgres"

# This is a bit of a hack. At the moment we have no means of starting background
# tasks from a Dockerfile. This workaround checks, on each bashrc eval, if the
# PostgreSQL server is running, and if not starts it.
RUN printf "\n# Auto-start PostgreSQL server.\n[[ \$(pg_ctl status | grep PID) ]] || pg_start > /dev/null\n" >> ~/.bashrc

WORKDIR /rails-template
USER student
# Install graphviz (Rails ERD)
RUN /bin/bash -l -c "sudo apt update && sudo apt install -y graphviz=2.42.2-3build2"

# Install fuser (bin/server) and expect (web_git)
RUN sudo apt install -y libpq-dev psmisc lsof expect

# Install parity
RUN wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add - \
    && echo "deb http://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list \
    && sudo apt-get update \
    && sudo apt-get -y install parity=3.5.0-2

# Install Node and npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - \
    && sudo apt-get install -y nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
    && sudo apt-get update \
    && sudo apt-get install -y yarn \
    && sudo npm install -g n \
    && sudo n 18 \
    && hash -r

# Install Redis.
RUN sudo apt-get update \
 && sudo apt-get install -y \
  redis-server=5:5.0.7-2ubuntu0.1 \
 && sudo rm -rf /var/lib/apt/lists/*

# Install heroku-cli
RUN /bin/bash -l -c "curl https://cli-assets.heroku.com/install.sh | sh"

# Install flyyctl
RUN /bin/bash -l -c "curl -L https://fly.io/install.sh | sh"
RUN echo "export PATH=\"/home/student/.fly/bin:\$PATH\"" >> ~/.bashrc

# Thoughtbot style bash prompt
RUN sudo wget -qO ./prompt "https://gist.githubusercontent.com/jelaniwoods/7e5db8d72b3dfac257b7eb562cfebf11/raw/af43083d91c0eb1489059a2ad9c39474a34ddbda/thoughtbot-style-prompt"
RUN /bin/bash -l -c "cat ./prompt >> ~/.bashrc"

# Git global configuration
RUN git config --global push.default upstream \
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
    && git config --global core.editor "code --wait"

# Alias 'git' to 'g'
# RUN echo 'export PATH="$PATH:$GITPOD_REPO_ROOT/bin"' >> ~/.bashrc
RUN echo "# No arguments: 'git status'\n\
# With arguments: acts like 'git'\n\
g() {\n\
  if [[ \$# > 0 ]]; then\n\
    git \$@\n\
  else\n\
    git status\n\
  fi\n\
}\n# Complete g like git\n\
source /usr/share/bash-completion/completions/git\n\
__git_complete g __git_main" >> ~/.bash_aliases

# Alias bundle exec to be
RUN echo "alias be='bundle exec'" >> ~/.bash_aliases
# RUN sudo cp -r /home/student /home/gitpod && sudo chmod 777 /home/gitpod

# Add bin/rake to path for non-Rails projects
RUN echo 'export PATH="$PWD/bin:$PATH"' >> ~/.bashrc
