#!/bin/bash
# Delete lock file if previous lock file remains
if [ -f installed.$APP_TYPE.lock ] && [ $APP_TYPE != "yard" ];then
  rm installed.$APP_TYPE.lock
fi
# Wait `bundle-installed` on web.
while [ "$APP_TYPE" != "web" ] && [ ! -f installed.$APP_TYPE.lock ]
do
  sleep 1
done
# Set bundle configs
bundle config --global --delete without
bundle config --global --delete frozen
bundle config --global system true
bundle config --global with 'development document test'
bundle install
# Only run web, because these should not overlap.
if [ "$APP_TYPE" = "web" ];then
  # Recreate bins. It only run on web server and production.
  rm -rf /var/www/docker/bin
  bundle exec rake app:update:bin
  bundle exec rails webpacker:binstubs
  bundle exec spring binstub --all
  # In development, create marker after `bundler installed`.
  touch installed.asciidoctor.lock
  touch installed.browser-sync.lock
  touch installed.guard.lock
  touch installed.worker.lock
  touch installed.bundle.lock
fi