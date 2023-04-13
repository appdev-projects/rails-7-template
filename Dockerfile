FROM ruby:3.2

WORKDIR /rails-template

# Install Google Chrome
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | \
    tee -a /etc/apt/sources.list.d/google.list' && \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | \
    apt-key add - && \
    apt-get update && \
    apt-get install -y google-chrome-stable libxss1

# Install Chromedriver (compatable with Google Chrome version)
#   See https://gerg.dev/2021/06/making-chromedriver-and-chrome-versions-match-in-a-docker-image/
RUN BROWSER_MAJOR=$(google-chrome --version | sed 's/Google Chrome \([0-9]*\).*/\1/g') && \
    wget https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${BROWSER_MAJOR} -O chrome_version && \
    wget https://chromedriver.storage.googleapis.com/`cat chrome_version`/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip && \
    mv chromedriver /usr/local/bin/ && \
    DRIVER_MAJOR=$(chromedriver --version | sed 's/ChromeDriver \([0-9]*\).*/\1/g') && \
    echo "chrome version: $BROWSER_MAJOR" && \
    echo "chromedriver version: $DRIVER_MAJOR" && \
    if [ $BROWSER_MAJOR != $DRIVER_MAJOR ]; then echo "VERSION MISMATCH"; exit 1; fi

# Get install-packages
RUN wget -qO /usr/bin/install-packages "https://gist.githubusercontent.com/jelaniwoods/d5cc8157a0de0f449de748f75e2e182e/raw/c45b0f2947975ff7bb53cbddb8a2fe2e6241db8e/install-packages" \
  && chmod 775 /usr/bin/install-packages
# Install PostgreSQL
RUN install-packages postgresql postgresql-contrib

# Setup PostgreSQL server
ENV PATH="$PATH:/usr/lib/postgresql/12/bin"
ENV PGDATA="/workspace/.pgsql/data"
RUN mkdir -p ~/.pg_ctl/bin ~/.pg_ctl/sockets \
 && printf '#!/bin/bash\n[ ! -d $PGDATA ] && mkdir -p $PGDATA && initdb -D $PGDATA\npg_ctl -D $PGDATA -l ~/.pg_ctl/log -o "-k ~/.pg_ctl/sockets" start\n' > ~/.pg_ctl/bin/pg_start \
 && printf '#!/bin/bash\npg_ctl -D $PGDATA -l ~/.pg_ctl/log -o "-k ~/.pg_ctl/sockets" stop\n' > ~/.pg_ctl/bin/pg_stop \
 && chmod +x ~/.pg_ctl/bin/*
ENV PATH="$PATH:$HOME/.pg_ctl/bin"
ENV DATABASE_URL="postgresql://root@localhost"
ENV PGHOSTADDR="127.0.0.1"
ENV PGDATABASE="postgres"

# This is a bit of a hack. At the moment we have no means of starting background
# tasks from a Dockerfile. This workaround checks, on each bashrc eval, if the
# PostgreSQL server is running, and if not starts it.
RUN printf "\n# Auto-start PostgreSQL server.\n[[ \$(pg_ctl status | grep PID) ]] || pg_start > /dev/null\n" >> ~/.bashrc

# Install Graphviz
RUN apt-get update \
  && apt-get install -y graphviz

# Install fuser (bin/server) and expect (web_git)
RUN apt install -y libpq-dev psmisc lsof expect

# Install Node and npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
 && apt-get install -y nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn \
    && npm install -g n \
    && n 18 \
    && hash -r

# Install parity gem
RUN wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | apt-key add - \
    && echo "deb http://apt.thoughtbot.com/debian/ stable main" | tee /etc/apt/sources.list.d/thoughtbot.list \
    && apt-get update \
    && apt-get -y install parity

# Install heroku-cli
RUN /bin/bash -l -c "curl https://cli-assets.heroku.com/install.sh | sh"

# Install flyyctl
RUN /bin/bash -l -c "curl -L https://fly.io/install.sh | sh"
RUN echo "export PATH=\"/home/gitpod/.fly/bin:\$PATH\"" >> ~/.bashrc

# Git global configuration
RUN git config --global push.default upstream \
    && git config --global merge.ff only \
    && git config --global alias.acm '!f(){ git add -A && git commit -am "${*}"; };f' \
    && git config --global alias.as '!git add -A && git stash' \
    && git config --global alias.p 'push' \
    && git config --global alias.sla 'log --oneline --decorate --graph --all' \
    && git config --global alias.co 'checkout' \
    && git config --global alias.cob 'checkout -b'

# Alias 'git' to 'g'
RUN echo 'export PATH="$PATH:$PWD/bin"' >> ~/.bashrc
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
