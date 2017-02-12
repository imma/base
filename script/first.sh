#!/usr/bin/env bash

function main {
  set -exfu

  if systemctl 2>&1 >/dev/null; then
    while true; do
      case "$(echo | "$@" systemctl is-active cloud-final.service)" in
        active|failed) break ;;
        *) echo "Waiting for cloud-init"; sleep 5 ;;
      esac
    done
  fi

  export DEBIAN_FRONTEND=noninteractive 

  dpkg --remove-architecture i386

  export DEBIAN_FRONTEND=noninteractive
  apt-get install -y software-properties-common python-software-properties openssh-server aptitude
  env - add-apt-repository -y ppa:git-core/ppa
  env - add-apt-repository -y ppa:ubuntu-lxc/lxd-stable
  aptitude update -y && sudo -E aptitude upgrade -y
  aptitude install -y net-tools sudo cloud-init git openssh-server curl unzip perl ruby python language-pack-en build-essential vim man screen tmux
}

main "$@"
