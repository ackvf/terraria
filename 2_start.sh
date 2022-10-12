#!/bin/bash
set -euxo pipefail

cd /terraria/server

CMD="./TerrariaServer.exe -x64 -config /terraria/config/$FILENAME_CONFIG -banlist /terraria/config/$FILENAME_BANLIST -logpath /terraria/config/logs"

# Create default config files if they don't exist

if [ ! -f "/terraria/config/$FILENAME_CONFIG" ]; then
  echo "Server configuration not found, running with default server configuration."
  cp /terraria/server/serverconfig-default.txt /terraria/config/$FILENAME_CONFIG
fi

if [ ! -f "/terraria/config/$FILENAME_BANLIST" ]; then
  touch /terraria/config/$FILENAME_BANLIST
fi

# Link Worlds folder to /terraria/config so it will save to the correct location
if [ ! -s "/root/.local/share/Terraria/Worlds" ]; then
  mkdir -p /root/.local/share/Terraria
  ln -sT /terraria/config /root/.local/share/Terraria/Worlds
fi

# Pass in world if set, otherwise generate new world with serverconfig.txt parameters or command flags

if [ -z "$FILENAME_WORLD" ]; then
  echo "No world file specified in environment FILENAME_WORLD."
  if [ -z "$@" ]; then
    echo "Running server setup..."
  else
    echo "Running server with command flags: $@"
  fi
  #mono TerrariaServer.exe -config "/terraria/config/$FILENAME_CONFIG" -logpath "$LOGPATH" "$@"
else
  echo "Loading world $FILENAME_WORLD..."
  if [ ! -f "/terraria/config/$FILENAME_WORLD" ]; then
    echo "World file does not exist! Quitting..."
    exit 1
  fi
  #mono TerrariaServer.exe -config "$CONFIGPATH/$CONFIG_FILENAME" -logpath "/terraria/config/logs" -world "$FILENAME_WORLD" "$@"
  CMD="$CMD -world /terraria/config/$FILENAME_WORLD"
fi

echo "Starting container, CMD: $CMD $@"
mono $CMD $@
