#!/bin/bash
# set env
. $(dirname $BASH_SOURCE)/../bootstrap.sh worker $1
cd /var/www/docker
yarn install --check-files
bundle exec sidekiq -q default