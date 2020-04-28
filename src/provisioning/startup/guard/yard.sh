#!/bin/bash
. $(dirname $BASH_SOURCE)/../bootstrap.sh guard
cd /var/www/docker
if [ -z "$1" ]; then
    bundle exec yard doc -o doc/yard
else
    bundle exec yard doc -o doc/yard --files $1
fi