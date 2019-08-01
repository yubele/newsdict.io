# define ubuntu version, you can use --build-arg
ARG ubuntu_version="18.10"
FROM ubuntu:${ubuntu_version}

# Dockerfile on bash
SHELL ["/bin/bash", "-c"]

# default node version, you can use --build-arg
ARG node_version="v12.4.0"

# default ruby version, you can use --build-arg
ARG ruby_version="2.6.3"

RUN apt update
RUN apt install -y vim git curl yarn libmecab-dev mecab-ipadic-utf8 libmagickwand-dev openjdk-8-jdk nodejs graphicsmagick graphviz curl nginx

# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install -y yarn

# installv nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
ENV NVM_DIR "/root/.nvm"
RUN . ${NVM_DIR}/nvm.sh \
    && nvm install ${node_version} \
    && nvm alias default ${node_version}

# install rvm
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN . /etc/profile.d/rvm.sh \
    && rvm install ${ruby_version} \
    && gem install bundler


RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set correct environment variables.
RUN mkdir -p /var/www/docker
WORKDIR /var/www/docker

# Set up application
COPY . .
COPY src/provisioning/nginx/sites-available/default /etc/nginx/sites-available/default
COPY src/provisioning/startup.sh /startup.sh

# Initialize rails
RUN yarn install --production --check-files \
    && . /etc/profile.d/rvm.sh \
    && bundle install --path .bundle --deployment --without development test --quiet

# Start application
RUN if [ -f /var/www/docker/tmp/pids/server.pid ]; then \
        rm /var/www/docker/tmp/pids/server.pid; \
    fi
RUN . /etc/profile.d/rvm.sh \
    && bin/rails log:clear \
    && RAILS_ENV=production EDITOR="mate --wait" bin/rails credentials:edit
CMD ["bash", "/startup.sh"]

EXPOSE 80 8080 3036
