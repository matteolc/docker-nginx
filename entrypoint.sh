#!/bin/bash
set -e
source ${HOME}/functions

[[ ${DEBUG} == true ]] && set -x

# allow arguments to be passed to nginx
if [[ ${1:0:1} = '-' ]]; then
  EXTRA_ARGS="$@"
  set --
elif [[ ${1} == nginx || ${1} == $(which nginx) ]]; then
  EXTRA_ARGS="${@:2}"
  set --
fi

# default behaviour is to launch nginx
if [[ -z ${1} ]]; then

  create_dh
  create_cert
  set_default_config
  
  echo "Starting nginx ..."
  nginx -g "daemon off;" &

  nginx_pid=$!  

  setup_amplify

  #echo "Starting monit"
  #service monit start

  wait ${nginx_pid}
  echo "nginx master process has stopped, exiting."

else
  exec "$@"
fi