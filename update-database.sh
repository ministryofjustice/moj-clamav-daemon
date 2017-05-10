#!/bin/bash

set -euo pipefail

echo "disable server clamav-backend/clamav3311" | socat stdio /haproxysock
# This causes clamd to reload the database
kill -SIGUSR2 `cat /clamd3311.pid`
# It normally takes about 20 seconds to reload.
sleep 40
echo "enable server clamav-backend/clamav3311" | socat stdio /haproxysock

sleep 10

echo "disable server clamav-backend/clamav3312" | socat stdio /haproxysock
# This causes clamd to reload the database
kill -SIGUSR2 `cat /clamd3312.pid`
# It normally takes about 20 seconds to reload.
sleep 40
echo "enable server clamav-backend/clamav3312" | socat stdio /haproxysock
