#!/usr/bin/env bash

set -exfu

function main {
  apt-get install -y build-essential perl dkms

  echo "==> Installing VirtualBox guest additions"

  VBOX_VERSION=$(cat /home/ubuntu/.vbox_version)
  mount -o loop /home/ubuntu/VBoxGuestAdditions.iso /mnt
  # sh -x /mnt/VBoxLinuxAdditions.run
  umount /mnt
  rm /home/ubuntu/VBoxGuestAdditions.iso
  rm /home/ubuntu/.vbox_version
}

main "$@"
