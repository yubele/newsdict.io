#!/bin/bash
# set env
. $(dirname $BASH_SOURCE)/../bootstrap.sh bundle $1
cd /var/www/docker
irb