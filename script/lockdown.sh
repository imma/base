#!/usr/bin/env bash

function main {
  set -exfu

  passwd -l ubuntu
  passwd -l root
}

main "$@"
