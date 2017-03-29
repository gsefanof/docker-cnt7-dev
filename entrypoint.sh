#!/bin/bash
set -e

# allow arguments to be passed to openfire launch
if [[ ${1:0:1} = '-' ]]; then
  EXTRA_ARGS="$@"
  set --
fi

function run_environment() {

  # SSH agent and keys
  export SSH_AUTH_SOCK SSH_AGENT_PID
  /usr/bin/ssh-agent

}

run_environment

# default behaviour is to launch 
if [[ -z ${1} ]]; then
  exec /bin/bash
else
  exec "$@"
fi


