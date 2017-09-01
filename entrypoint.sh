#!/bin/bash
set -e
source ${HOME}/functions

[[ ${DEBUG} == true ]] && set -x

# allow arguments to be passed to nginx
if [[ ${1:0:1} = '-' ]]; then
  EXTRA_ARGS="$@"
  set --
elif [[ ${1} == ${APP} || ${1} == $(which ${APP}) ]]; then
  EXTRA_ARGS="${@:2}"
  set --
fi

# default behaviour is to launch nginx
if [[ -z ${1} ]]; then

  create_dh
  create_cert
  set_default_config
  
  echo "Starting ${APP} ..."
  nginx -g "daemon off;" &
  nginx_pid=$!  

  setup_amplify

  wait ${nginx_pid}
  echo "${APP} has stopped, exiting."

else
  exec "$@"
fi