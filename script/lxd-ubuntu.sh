#!/usr/bin/env bash

function main {
  set -exfu

  mkdir -p ~ubuntu/.config/lx{c,d}
  chown ubuntu:ubuntu ~ubuntu/.config{,/lxc,/lxd}
}

main "$@"
