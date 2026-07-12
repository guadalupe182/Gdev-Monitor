#!/usr/bin/env bash

################################################################################
#
# GDEV TV MODE
#
# Activa un monitor virtual usando VKMS para utilizar Moonlight/Sunshine
#
################################################################################

set -e

#########################
# COLORES
#########################

GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"

ok() {
    echo -e "${GREEN}✔${RESET} $1"
}

warn() {
    echo -e "${YELLOW}⚠${RESET} $1"
}

error() {
    echo -e "${RED}✖${RESET} $1"
}

info() {
    echo -e "${BLUE}➜${RESET} $1"
}

################################################################################

clear

echo

echo "=============================================="
echo "        GDEV TV MODE v1.0"
echo "=============================================="

echo

################################################################################
# VERIFICACIONES
################################################################################

info "Verificando entorno..."

if [[ "$XDG_SESSION_TYPE" != "x11" ]]; then
    error "Este script sólo funciona en X11."
    exit 1
fi

ok "Sesión X11"

################################################################################

info "Verificando xrandr..."

command -v xrandr >/dev/null || {
    error "xrandr no está instalado."
    exit 1
}

ok "xrandr encontrado"

################################################################################

info "Cargando VKMS..."

sudo modprobe vkms

sleep 2

################################################################################

info "Esperando monitor virtual..."

for i in {1..10}; do

    if xrandr | grep -q "Virtual-1-1"; then
        ok "Monitor detectado."
        break
    fi

    sleep 1

done

################################################################################

if ! xrandr | grep -q "Virtual-1-1"; then

    error "No apareció Virtual-1-1"

    exit 1

fi

################################################################################

info "Configurando resolución..."

xrandr \
    --output Virtual-1-1 \
    --mode 1280x720 \
    --right-of eDP-1

ok "Resolución aplicada"

################################################################################

echo

info "Monitores actuales"

echo

xrandr --listmonitors

################################################################################

echo

echo "=============================================="

ok "Modo TV activado."

echo

echo "Ahora solamente abre Moonlight"

echo

echo "Desktop"

echo

echo "y disfruta tu segundo monitor 😎"

echo
# ... Todo el código anterior de xrandr que ya tenías ...

echo
echo "=============================================="

ok "Modo TV activado."

echo

echo "Ahora solamente abre Moonlight"

echo

echo "Desktop"

echo

echo "y disfruta tu segundo monitor 😎"

# ==============================================
#   INICIANDO SUNSHINE EN SEGUNDO PLANO
# ==============================================
echo
info "Lanzando servidor Sunshine en segundo plano..."

# Obtenemos la ruta absoluta del directorio donde vive este script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ejecuta sunshine.sh de fondo y manda los logs a un archivo temporal
"$SCRIPT_DIR/sunshine.sh" > /tmp/sunshine.log 2>&1 &

ok "Sunshine corriendo de fondo (Logs en /tmp/sunshine.log)"

echo
