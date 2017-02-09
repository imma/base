#!/usr/bin/env bash

set -exfu

function main {
  echo "==> Installing VirtualBox guest additions"

  aptitude install -y build-essential perl dkms

  VBOX_VERSION=$(cat /home/ubuntu/.vbox_version)
  mount -o loop /home/ubuntu/VBoxGuestAdditions.iso /mnt
  sh /mnt/VBoxLinuxAdditions.run
  umount /mnt
  rm /home/ubuntu/VBoxGuestAdditions.iso
  rm /home/ubuntu/.vbox_version
}

main "$@"
