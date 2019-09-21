#!/bin/bash
. /etc/profile.d/rvm.sh
cd /var/www/docker
/usr/sbin/nginx -c /etc/nginx/nginx.conf
RAILS_ENV=production bundle install --path .bundle --deployment --without development test --quiet
NODE_ENV=production yarn install --check-files
RAILS_ENV=production bundle exec rails db:seed
RAILS_ENV=production bundle exec bin/rails log:clear
EDITOR="mate --wait" bundle exec bin/rails credentials:edit
RAILS_ENV=production bundle exec bin/rails webpacker:compile
RAILS_ENV=production bundle exec bin/rails assets:precompile
RAILS_LOG_TO_STDOUT=true RAILS_ENV=production bundle exec bin/rails server