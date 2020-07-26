#!/bin/bash
VERSION=3.9.2

if [ -z $1 ];then
    echo "Must be filename"
    echo " ex) bash src/provisioning/startup/asciidoctor/revealjs.sh src/doc/exsample.adoc"
    exit 1
fi

out_file=$(echo $1 | sed "s#src/##" | sed "s#\.adoc#.html#")

bundle exec asciidoctor-revealjs   -a revealjsdir=https://cdn.jsdelivr.net/npm/reveal.js@$VERSION -o doc/revealjs/$out_file $1