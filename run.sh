#!/bin/bash

set -euo pipefail

# Do an initial run in the foreground to ensure the database is present and
# current.
freshclam --config-file=/freshclam.conf --pid=/var/lib/clamav/freshclam-first.pid

# And now run it as a daemon to make sure the database stays up to date.
freshclam --config-file=/freshclam.conf --pid=/var/lib/clamav/freshclam.pid -d &

# And start clamd in the background.
clamd --config-file=/clamd.conf &

# Rsyslog is installed and started because neither clamd nor freshclam can
# write to /dev/stdout. They attempt to open it in append mode, which raises an
# error.
# Rsyslog has to be started last and run in the foreground, otherwise, the
# output of whatever process is started last takes precedence.
rsyslogd -n
