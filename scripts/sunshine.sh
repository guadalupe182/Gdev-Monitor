#!/usr/bin/env bash

set -euo pipefail

# Colores bonitos para la terminal
BLUE="\033[1;34m"
RESET="\033[0m"

echo -e "${BLUE}➜ Iniciando servidor Sunshine (Flatpak)...${RESET}"

# Ejecuta el Flatpak de Sunshine directamente
exec flatpak run dev.lizardbyte.app.Sunshine
