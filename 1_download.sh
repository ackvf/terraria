#!/bin/bash
set -euxo pipefail

URL="https://www.terraria.org/api/download/pc-dedicated-server/terraria-server-$DOWNLOAD_VERSION.zip"
echo Downloading: $URL

mkdir -p /terraria/tmp
cd /terraria/tmp

curl -sL $URL --output terraria-server.zip
unzip -oq terraria-server.zip

# Troubleshooting https://terraria.fandom.com/wiki/Server#Troubleshooting
rm */Linux/System.dll

rm -Rf /terraria/server
mv */Linux /terraria/server
mv */Windows/serverconfig.txt /terraria/server/serverconfig-default.txt

rm -R /terraria/tmp/*

chmod +x /terraria/server/TerrariaServer*
if [ ! -f /terraria/server/TerrariaServer ]; then echo "Missing /terraria/server/TerrariaServer"; exit 1; fi

echo Download complete
