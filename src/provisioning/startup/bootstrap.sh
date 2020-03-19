#!/bin/bash
# Initialize enviroment
if [ ! -z $1 ];then
  export APP_TYPE=$1
else
  exit 1
fi
if [ ! -z $2 ];then
  export RAILS_ENV=$2
  export NODE_ENV=$2
fi
if [ "$APP_TYPE" != "web" ];then
  sleep 0
fi
while [ "$RAILS_ENV" = "development" ] && [ "$APP_TYPE" != "web" ] && [ ! -f installed.$APP_TYPE.lock ]
do
  sleep 1
done
if [ -f installed.$APP_TYPE.lock ];then
  rm installed.$APP_TYPE.lock
fi
# Initialize nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Initialize rvm
. /etc/profile.d/rvm.sh
# Install the gems of bundler
if [ "$RAILS_ENV" != "development" ];then
  bundle install
elif [ "$APP_TYPE" = "web" ] && [ "$RAILS_ENV" = "development" ];then
# Only run bundler in web when env is development.
  bundle config --global --delete without
  bundle config --global --delete frozen
  rm Gemfile.lock # Run only when docker-compose build
  bundle install
fi
# Recreate bins. It only run on web server and production.
if [ "$RAILS_ENV" = "production" ] || [ "$APP_TYPE" = "web" ];then
  rm -rf /var/www/docker/bin
  bundle exec rake app:update:bin
  bundle exec rails webpacker:binstubs
  bundle exec spring binstub --all
fi
# Start webpack-dev-server
if [ "$RAILS_ENV" = "development" ];then
  bin/webpack-dev-server &
fi
# In development, create marker after `bundler installed`.
if [ "$RAILS_ENV" = "development" ] && [ "$APP_TYPE" = "web" ];then
  touch installed.document.lock
  touch installed.worker.lock
fi