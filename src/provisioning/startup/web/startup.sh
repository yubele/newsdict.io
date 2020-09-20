#!/bin/bash
# set env
. $(dirname $BASH_SOURCE)/../bootstrap.sh web $1
cd /var/www/docker
bundle exec bin/rails log:clear
EDITOR="mate --wait" bundle exec bin/rails credentials:edit
yarn install --check-files
bundle exec bin/rails assets:precompile
bundle exec bin/rails db:seed
# If you don't have an SSL certificate, put sleep because you want to create a certificate on `rails server` first and then run it.
sleep 5 && bin/webpack-dev-server &
bundle exec bin/rails server