#!/bin/bash
# set env
. $(dirname $BASH_SOURCE)/../bootstrap.sh webpack-dev-server $1
cd /var/www/docker
bin/webpack-dev-server