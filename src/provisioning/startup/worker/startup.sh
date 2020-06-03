#!/bin/bash
# set env
. $(dirname $BASH_SOURCE)/../bootstrap.sh worker $1
cd /var/www/docker
bundle exec sidekiq