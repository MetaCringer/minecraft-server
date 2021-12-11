#!/bin/bash
set -e
/scripts/${SCRIPT_NAME}
#exec java -Xms1g -Xmx${mx_ram} -jar forge.jar $@