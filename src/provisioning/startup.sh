#!/bin/bash
source /etc/profile.d/rvm.sh
/usr/sbin/nginx -c /etc/nginx/nginx.conf
RAILS_LOG_TO_STDOUT=true RAILS_ENV=production bin/rails server -b 0.0.0.0