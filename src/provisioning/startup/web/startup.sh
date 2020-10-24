#!/bin/bash
# set env
. $(dirname $BASH_SOURCE)/../bootstrap.sh web $1
cd /var/www/docker
bundle exec bin/rails log:clear
yarn install --check-files
bundle exec bin/rails assets:precompile
bundle exec bin/rails db:seed
bin/webpack-dev-server &
bundle exec bin/rails server