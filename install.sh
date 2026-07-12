#!/usr/bin/env bash
# install.sh

echo "[INFO] Instalando GDEV TV Mode globalmente..."
sudo mkdir -p /usr/local/bin

# Copiar el wrapper principal al sistema
sudo cp bin/gdev-tv /usr/local/bin/gdev-tv
sudo chmod +x /usr/local/bin/gdev-tv

# Asegurar permisos de los scripts internos
chmod +x scripts/*.sh

echo "[OK] ¡Instalación completada! Ya puedes usar 'gdev-tv' desde cualquier terminal."
