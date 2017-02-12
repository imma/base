#!/usr/bin/env bash

function main {
  set -exfu

  while true; do
    case "$(echo | "$@" systemctl is-active cloud-final.service)" in
      active|failed) break ;;
      *) echo "Waiting for cloud-init"; sleep 5 ;;
    esac
  done
}

main "$@"
