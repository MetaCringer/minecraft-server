#!/bin/bash
set -e
./scripts/deploy.sh
#exec java -Xms1g -Xmx${mx_ram} -jar forge.jar $@