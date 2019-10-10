#!/bin/bash
# set env
. $(dirname $BASH_SOURCE)/../bootstrap.sh $1
/usr/sbin/nginx -c /etc/nginx/nginx.conf
cd /var/www/docker
yarn install --check-files
# Compile docs
for i in $(find src/doc -name '*.adoc')
do
    _file=$i
    _name=$(echo $i | sed "s#src/##" |sed 's/\.adoc//')
    bundle exec asciidoctor -r asciidoctor-diagram $_file -o $_name.html
done
bundle exec yard
# Watch to modify
if [ -z $RAILS_ENV ];then
  bundle exec guard
fi