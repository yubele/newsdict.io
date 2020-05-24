#!/bin/bash
. $(dirname $BASH_SOURCE)/../bootstrap/initialize.sh guard $1
bin/rails assets:precompile
touch tmp/restart.txt