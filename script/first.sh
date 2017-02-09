#!/usr/bin/env bash

set -exfu

while true; do
  case "$(echo | "$@" systemctl is-active cloud-final.service)" in
    active|failed) break ;;
    *) echo "Waiting for cloud-init"; sleep 5 ;;
  esac
done

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
