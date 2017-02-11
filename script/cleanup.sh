#!/usr/bin/env bash

function main {
  set -exfu

  rm -rf /dev/.udev/
  rm -f /lib/udev/rules.d/75-persistent-net-generator.rules

  rm -f /var/lib/dhcp/*

  rm -rf /tmp/*

  apt-get -y autoremove --purge
  apt-get -y clean
  apt-get -y autoclean
}

main "$@"
