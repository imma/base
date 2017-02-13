#!/usr/bin/env bash

function main {
  set -exfu

  case "$(uname -s)" in
    Linux)
      if "$@" systemctl 2>&1 >/dev/null; then
        while true; do
          case "$(echo | "$@" systemctl is-active cloud-final.service || true)" in
            active|failed) break ;;
            *) echo "Waiting for cloud-init"; sleep 5 ;;
          esac
        done
      fi
      ;;
  esac
}

main "$@"
