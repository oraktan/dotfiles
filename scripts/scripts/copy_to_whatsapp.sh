#!/bin/bash

DEST=~/whatsapp
mkdir -p "$DEST"

# Yazi selected dosyaları newline olarak verir
echo "$@" | while read -r file; do
    cp -r "$file" "$DEST"
done
