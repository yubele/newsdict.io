#!/bin/bash
# set env
. $(dirname $BASH_SOURCE)/../bootstrap.sh $1
/usr/sbin/nginx -c /etc/nginx/nginx.conf
cd /var/www/docker
yarn install --check-files
bin/generate_all_documents
if [ -z $RAILS_ENV ];then
  bundle exec guard
fi