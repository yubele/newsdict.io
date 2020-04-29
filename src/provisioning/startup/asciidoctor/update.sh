#!/bin/bash
if [ "$(echo $2 | grep -e "index$" 2>&1 >/dev/null; echo $?)" = "0" ]; then
    output=$2.html
else
    output=$2/index.html
fi
bundle exec asciidoctor --safe-mode unsafe \
    -r asciidoctor-diagram \
    -a stylesheet=/var/www/docker/asciidoctor-skins/css/clean.css \
    -a lang=ja -b html5 -d book  $1 -o $output