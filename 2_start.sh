#!/bin/bash
set -euxo pipefail

CMD="./TerrariaServer -x64 -config /config/$FILENAME_CONFIG -banlist /config/$FILENAME_BANLIST -logpath /config/logs"

# Create default config files if they don't exist

if [ ! -f "/config/$FILENAME_CONFIG" ]; then
  echo "Server configuration not found, running with default server configuration."
  cp /server/serverconfig-default.txt /config/$FILENAME_CONFIG
fi

if [ ! -f "/config/$FILENAME_BANLIST" ]; then
  touch /config/$FILENAME_BANLIST
fi

# Link Worlds folder to /config so it will save to the correct location
if [ ! -s "/root/.local/share/Terraria/Worlds" ]; then
  mkdir -p /root/.local/share/Terraria
  ln -sT /config /root/.local/share/Terraria/Worlds
fi

# Pass in world if set, otherwise generate new world with serverconfig.txt parameters or command flags

if [ -z "$FILENAME_WORLD" ]; then
  echo "No world file specified in environment FILENAME_WORLD."
  if [ -z "$@" ]; then
    echo "Running server setup..."
  else
    echo "Running server with command flags: $@"
  fi
  #mono TerrariaServer.exe -config "config/$FILENAME_CONFIG" -logpath "$LOGPATH" "$@"
else
  echo "Loading world $FILENAME_WORLD..."
  #mono TerrariaServer.exe -config "$CONFIGPATH/$CONFIG_FILENAME" -logpath "/config/logs" -world "$FILENAME_WORLD" "$@"
  CMD="$CMD -world /config/$FILENAME_WORLD"
fi

echo "Starting container, CMD: $CMD $@"
exec $CMD $@
