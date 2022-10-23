#!/bin/bash
set -euo pipefail
#set -euxo pipefail # useful during development

echo "Bootstrap"

./1_download.sh
./2_start.sh
