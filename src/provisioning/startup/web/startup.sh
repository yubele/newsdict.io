#!/bin/bash
# set env
. $(dirname $BASH_SOURCE)/../bootstrap.sh $1
/usr/sbin/nginx -c /etc/nginx/nginx.conf
cd /var/www/docker
bundle exec bin/rails log:clear
EDITOR="mate --wait" bundle exec bin/rails credentials:edit
bundle exec bin/rails webpacker:compile
bundle exec bin/rails assets:precompile
bundle exec bin/rails db:seed
RAILS_LOG_TO_STDOUT=true bundle exec bin/rails server