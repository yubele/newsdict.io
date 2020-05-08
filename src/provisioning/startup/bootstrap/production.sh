#!/bin/bash
# Recreate bins. It only run on web server and production.
rm -rf /var/www/docker/bin
bundle exec rake app:update:bin
bundle exec rails webpacker:binstubs
bundle exec spring binstub --all