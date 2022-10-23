#!/bin/bash
set -euo pipefail
#set -euxo pipefail # useful during development

echo "Downloading..."

# Create a temporary folder and download & extract specified server version to it

URL="https://www.terraria.org/api/download/pc-dedicated-server/terraria-server-$DOWNLOAD_VERSION.zip"
echo "URL: $URL"

mkdir -p /terraria/tmp
cd /terraria/tmp

curl -sL $URL --output terraria-server.zip
unzip -oq terraria-server.zip

# Troubleshooting https://terraria.fandom.com/wiki/Server#Troubleshooting
rm */Linux/System.dll

# Copy extracted Linux version and default config files

rm -Rf /terraria/server
mv */Linux /terraria/server
mv */Windows/serverconfig.txt /terraria/server/serverconfig-default.txt

rm -Rf /terraria/tmp/*

chmod +x /terraria/server/TerrariaServer*
if [ ! -f /terraria/server/TerrariaServer ]; then echo "Missing /terraria/server/TerrariaServer executable"; exit 1; fi

echo "Download complete"
