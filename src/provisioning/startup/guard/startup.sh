#!/bin/bash
. $(dirname $BASH_SOURCE)/../bootstrap.sh guard $1
cd /var/www/docker
bundle exec guard