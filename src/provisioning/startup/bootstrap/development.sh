#!/bin/bash
# Delete lock file if previous lock file remains
if [ -f tmp/locks/installed.$APP_TYPE.lock ] && [ $APP_TYPE != "yard" ];then
  rm tmp/locks/installed.$APP_TYPE.lock
fi
# Wait `bundle-installed` on web.
while [ "$APP_TYPE" != "web" ] && [ ! -f tmp/locks/installed.$APP_TYPE.lock ]
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
  . $(dirname $BASH_SOURCE)/production.sh
  # In development, create marker after `bundler installed`.
  mkdir -p tmp/locks
  touch tmp/locks/installed.asciidoctor.lock
  touch tmp/locks/installed.browser-sync.lock
  touch tmp/locks/installed.guard.lock
  touch tmp/locks/installed.worker.lock
  touch tmp/locks/installed.bundle.lock
fi
bundle exec bin/rails tmp:clear
# Create cert
ruby $(dirname $BASH_SOURCE)/create_cert.rb