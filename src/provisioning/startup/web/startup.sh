#!/bin/bash
# set env
. $(dirname $BASH_SOURCE)/../bootstrap.sh web $1
cd /var/www/docker
bundle exec bin/rails log:clear
EDITOR="mate --wait" bundle exec bin/rails credentials:edit
yarn install --check-files
bundle exec bin/rails webpacker:compile
bundle exec bin/rails assets:precompile
bundle exec bin/rails db:seed
RAILS_LOG_TO_STDOUT=true bundle exec bin/rails server