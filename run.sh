#!/bin/bash

set -euo pipefail

# Rsyslog is installed and started because neither clamd nor freshclam can
# write to /dev/stdout. They attempt to open it in append mode, which raises an
# error.
rsyslogd
# Run it once in the foreground to ensure the database is in place prior to launching clam.
freshclam --config-file=/freshclam-foreground.conf
# And now run it as a daemon to make sure the database stays up to date.
freshclam --config-file=/freshclam.conf -d &
clamd --config-file=/clamd.conf
