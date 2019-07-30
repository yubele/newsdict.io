#!/bin/bash
source /etc/profile.d/rvm.sh
/usr/sbin/nginx -c /etc/nginx/nginx.conf
yarn install --check-files
RAILS_ENV=production bin/rails assets:precompile
RAILS_ENV=production bin/rails webpacker:compile
RAILS_LOG_TO_STDOUT=true RAILS_ENV=production bin/rails server