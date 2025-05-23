#!/bin/bash

# Equibop Simple Updater
# Lädt automatisch die neueste Version herunter

set -e

INSTALL_DIR="/opt/equibop"
SYMLINK_PATH="/usr/local/bin/equibop"
DOWNLOAD_URL="https://github.com/Equicord/Equibop/releases/latest/download/Equibop-linux-x64.tar.gz"

# Farben
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== Equibop Updater ===${NC}"

# Root-Check
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}Bitte als root ausführen (sudo)${NC}"
   exit 1
fi

# Verzeichnis erstellen falls nicht vorhanden
echo "Erstelle Verzeichnis $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"

# Alte Installation sichern
if [[ -d "$INSTALL_DIR" ]] && [[ "$(ls -A $INSTALL_DIR)" ]]; then
    echo "Sichere alte Installation..."
    rm -rf "$INSTALL_DIR.backup"
    cp -r "$INSTALL_DIR" "$INSTALL_DIR.backup"
fi

# Download
echo "Lade neueste Version herunter..."
curl -L --progress-bar -o "/tmp/equibop.tar.gz" "$DOWNLOAD_URL"

# Entpacken
echo "Entpacke..."
tar -xzf "/tmp/equibop.tar.gz" -C "$INSTALL_DIR" --strip-components=1

# Ausführbar machen
chmod +x "$INSTALL_DIR/equibop"

# Symlink erstellen/aktualisieren
echo "Erstelle/Aktualisiere Symlink..."
rm -f "$SYMLINK_PATH"
ln -s "$INSTALL_DIR/equibop" "$SYMLINK_PATH"

# Prüfen ob Symlink erstellt wurde
if [[ -L "$SYMLINK_PATH" ]]; then
    echo -e "${GREEN}Symlink erfolgreich erstellt${NC}"
else
    echo -e "${RED}Fehler beim Erstellen des Symlinks!${NC}"
fi

# Aufräumen
rm -f "/tmp/equibop.tar.gz"

echo -e "${GREEN}✅ Fertig! Starte mit: equibop${NC}"