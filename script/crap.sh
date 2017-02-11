#!/usr/bin/env bash

function main {
  set -exfu

  systemctl disable apt-daily.service
  systemctl disable apt-daily.timer
}

main "$@"
