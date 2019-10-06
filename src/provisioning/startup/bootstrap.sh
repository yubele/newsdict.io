#!/bin/bash
if [ ! -z $1 ];then
  export RAILS_ENV=$1
  export NODE_ENV=$1
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. /etc/profile.d/rvm.sh
if [ "$RAILS_ENV" = "production" ];then
  bundle install --path .bundle --deployment --without development test --quiet
else
  bundle install --path .bundle
  bin/webpack-dev-server &
fi