#!/bin/bash
. $(dirname $BASH_SOURCE)/../bootstrap.sh asciidoctor $1
cd /var/www/docker
# Compile docs
for i in $(find src/doc -name '*.adoc')
do
    bash src/provisioning/startup/asciidoctor/update.sh $i $(echo $i | sed "s#src/##" |sed 's/\.adoc//')
done
# Generate yard
bash src/provisioning/startup/guard/yard.sh
/usr/sbin/nginx -c /etc/nginx/nginx.conf -g 'daemon off;'