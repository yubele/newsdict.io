#!/bin/bash
# Initialize enviroment
if [ -z $1 ];then
  exit 1
else
  export APP_TYPE=$1
fi
if [ -z $2 ];then
  export RAILS_ENV=development
  export NODE_ENV=development
else
  export RAILS_ENV=$2
  export NODE_ENV=$2
fi
# Initialize
. src/provisioning/startup/bootstrap/initialize.sh
# Bootstrap by env
. src/provisioning/startup/bootstrap/$RAILS_ENV.sh