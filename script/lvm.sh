#!/usr/bin/env bash

set -exfu

function main {
  lvreduce -f -L 1M inception/placeholder
  lvcreate -l '50%FREE' -n lxd inception
  if ! lvcreate -T -l '50%FREE' inception/docker --poolmetadatasize 32M -c 1M; then
    true
  fi
  lvs
  df -klh
}

main "$@"
