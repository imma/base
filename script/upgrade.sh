#!/usr/bin/env bash

function main {
  set -exfu

  export DEBIAN_FRONTEND=noninteractive 

  dpkg --remove-architecture i386

  apt-get update >/dev/null
  apt-get install -y aptitude

  aptitude update >/dev/null
  if aptitude dist-upgrade -y; then
    if aptitude upgrade -y; then
      true
    fi
  fi
}

main "$@"
