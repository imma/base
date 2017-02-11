#!/usr/bin/env bash

function main {
  set -exfu

  lvreduce -f -L 1M inception/placeholder
  lvcreate -l '50%FREE' -n lxd inception
}

main "$@"
