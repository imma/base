#!/usr/bin/env bash

function main {
  lvreduce -f -L 1M inception/placeholder
  lvcreate -l '50%FREE' -n lxd inception
}

main "$@"
