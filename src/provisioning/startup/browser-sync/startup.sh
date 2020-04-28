#!/bin/bash
. $(dirname $BASH_SOURCE)/../bootstrap.sh browser-sync $1
cd /var/www/docker
npm run browser-sync