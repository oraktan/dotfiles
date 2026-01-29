#!/bin/bash
# Aktif workspace id'sini al
ACTIVE_WS=$(hyprctl -j monitors | jq '.[] | select(.focused==true).activeWorkspace.id')

# JSON formatında Waybar için yazdır
echo "{\"text\":\"$ACTIVE_WS\",\"alt\":\"Workspace $ACTIVE_WS\"}"

