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
# Initialize nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Initialize rvm
. /etc/profile.d/rvm.sh
# Install the gems of bundler
if [ "$RAILS_ENV" = "production" ];then
  bundle install --deployment --without development test --quiet
elif [ "$APP_TYPE" = "web" ];then
  bundle install
fi
# Recreate bins. In development, it only run on web server
if [ "$RAILS_ENV" = "production" ] || [ "$APP_TYPE" = "web" ];then
  rm -rf /var/www/docker/bin
  bundle exec rake app:update:bin
  bundle exec rails webpacker:binstubs
  bundle exec spring binstub --all
fi
# Start webpack-dev-server
if [ "$RAILS_ENV" != "production" ];then
  bin/webpack-dev-server &
fi