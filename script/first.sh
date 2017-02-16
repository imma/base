#!/usr/bin/env bash

function main {
  set -exfu

  if ! "$@" systemctl; then
    return 0
  fi

  (set +f; tail -f /var/log/cloud-init*log) &

	while true; do 
    case "$(echo | "$@" systemctl is-active cloud-final.service)" in
      active|failed) 
          pkill tail
          wait
          exit 0
        ;;
    esac
    sleep 1
  done
}

main "$@"
