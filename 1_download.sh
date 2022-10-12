#!/bin/bash
set -euxo pipefail

URL="https://www.terraria.org/api/download/pc-dedicated-server/terraria-server-$DOWNLOAD_VERSION.zip"
echo Downloading: $URL

mkdir /tmp/terraria
cd /tmp/terraria
curl -sL $URL --output terraria-server.zip
unzip -q terraria-server.zip
mv */Linux /server
mv */Windows/serverconfig.txt /server/serverconfig-default.txt
rm -R /tmp/*

ls -la

chmod +x /server/TerrariaServer*
if [ ! -f /server/TerrariaServer ]; then echo "Missing /server/TerrariaServer"; exit 1; fi
