#!/bin/bash

# Für jede von Nautilus übergebene Datei
echo "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" | while read -r video; do
    # Überspringe leere Zeilen
    [ -z "$video" ] && continue
    
    filename="${video%.*}.wav"
    
    ffmpeg -y -i "$video" -vn \
           -codec:a pcm_s24le \
           -ar 48000 \
           -map_metadata 0 \
           "$filename" \
           -loglevel error
done
