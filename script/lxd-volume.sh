#!/usr/bin/env bash

function main {
  if mkfs.btrfs /dev/inception/lxd; then
    mkdir -p /var/lib/lxd
    printf 'UUID=%s /var/lib/lxd btrfs user_subvol_rm_allowed\n' "$(blkid /dev/inception/lxd | cut -d\" -f2)" >> /etc/fstab
  fi
}

main "$@"
