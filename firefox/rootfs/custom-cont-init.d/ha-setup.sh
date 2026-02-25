#!/bin/bash
set -e

echo "[ha-setup] Setting up Home Assistant integration..."

# Persistent Firefox profile storage
# HA provides /data for persistent add-on storage
if [ ! -d "/data/.mozilla" ]; then
  if [ -d "/config/.mozilla" ]; then
    echo "[ha-setup] Moving existing Firefox profile to /data..."
    mv /config/.mozilla /data/.mozilla
  else
    mkdir -p /data/.mozilla
  fi
fi
rm -rf /config/.mozilla
ln -sf /data/.mozilla /config/.mozilla

# Downloads directory via HA shared storage
mkdir -p /share/firefox
if [ -d "/config/Downloads" ] && [ ! -L "/config/Downloads" ]; then
  rm -rf /config/Downloads
fi
ln -sf /share/firefox /config/Downloads

echo "[ha-setup] Setup complete."
