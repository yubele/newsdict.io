#!/bin/bash
# set env
. $(dirname $BASH_SOURCE)/../bootstrap.sh $1
bin/rails test $@