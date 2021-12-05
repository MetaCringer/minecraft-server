#!/bin/bash
set -e
exec java -Xms1g -Xmx${mx_ram} -jar forge.jar $@