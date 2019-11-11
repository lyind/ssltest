#!/bin/bash
#
# Start SSL test with given parameters
#

set -e

target="$1"

java -jar /app/ssltest.jar -connectonly "$target"
exit $?

