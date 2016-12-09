#!/usr/bin/env bash

set -e

CLAMD_TEST="echo '.' |nc localhost 3310"
FRESHCLAM_TEST="ps ax | grep -v 'grep' |  grep 'freshclam -d'"

# Copied from ../helper.sh
function wait_until_cmd() {
  cmd="$@"
  max_retries=20
  wait_time=${WAIT_TIME:-5}
  retries=0
  while true ; do
    if ! bash -c "${cmd}" &> /dev/null ; then
      retries=$((retries + 1))
      echo "Testing for readyness..."
      if [ ${retries} -eq ${max_retries} ]; then
        return 1
      else
        echo "Retrying, $retries out of $max_retries..."
        sleep ${wait_time}
      fi
    else

      return 0
    fi
  done
  echo
  return 1
}


function run_test() {
    if [ "${2}" == "POLL" ]; then
        wait_until_cmd "${1}"
    else
        ${1}
    fi
}

if [ -f /UPDATE_ONLY ]; then
    # Only check for freshclam...
      run_test eval "${FRESHCLAM_TEST}" $1
else
    # Test for clamd
    run_test ${CLAMD_TEST} $1

    if [ -f /UPDATE ]; then
        run_test eval "${FRESHCLAM_TEST}" $1
    fi
fi
