#!/usr/bin/env bash

################################################################################
#
# GDEV TV MODE
#
# Activa un monitor virtual usando VKMS para utilizar Moonlight/Sunshine
#
################################################################################

# Importar el módulo de logger de forma segura
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [[ -f "$ROOT_DIR/scripts/lib/logger.sh" ]]; then
    source "$ROOT_DIR/scripts/lib/logger.sh"
else
    echo "[ERROR] No se pudo cargar el logger en $ROOT_DIR/scripts/lib/logger.sh" >&2
    exit 1
fi

# Importar el módulo de spinner de forma segura
if [[ -f "$ROOT_DIR/scripts/lib/spinner.sh" ]]; then
    source "$ROOT_DIR/scripts/lib/spinner.sh"
else
    log_error "No se pudo cargar el spinner en $ROOT_DIR/scripts/lib/spinner.sh"
    exit 1
fi

set -e

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

log_info "Verificando entorno..."

if [[ "$XDG_SESSION_TYPE" != "x11" ]]; then
    log_error "Este script sólo funciona en X11."
    exit 1
fi

log_ok "Sesión X11 detectada."

################################################################################

log_info "Verificando xrandr..."

command -v xrandr >/dev/null || {
    log_error "xrandr no está instalado."
    exit 1
}

log_ok "xrandr encontrado."

################################################################################

log_info "Cargando VKMS..."

# Forzamos sudo aquí para que pongas la contraseña antes de lanzar el spinner
sudo true

sudo modprobe vkms &
show_spinner $!
echo ""

################################################################################

log_info "Esperando monitor virtual..."

for i in {1..10}; do
    if xrandr | grep -q "Virtual-1-1"; then
        log_ok "Monitor detectado."
        break
    fi
    sleep 1 &
    show_spinner $!
done

################################################################################

if ! xrandr | grep -q "Virtual-1-1"; then
    log_error "No apareció Virtual-1-1"
    exit 1
fi

################################################################################

log_info "Configurando resolución..."

xrandr \
    --output Virtual-1-1 \
    --mode 1280x720 \
    --right-of eDP-1

log_ok "Resolución aplicada (1280x720)."

################################################################################

echo
log_info "Monitores actuales:"
echo

xrandr --listmonitors

################################################################################
# INICIANDO SUNSHINE EN SEGUNDO PLANO
################################################################################

echo
log_info "Lanzando servidor Sunshine en segundo plano..."

# Obtenemos la ruta absoluta del directorio donde vive este script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ejecuta sunshine.sh de fondo y manda los logs a un archivo temporal
"$SCRIPT_DIR/sunshine.sh" > /tmp/sunshine.log 2>&1 &

log_ok "Sunshine corriendo de fondo (Logs en /tmp/sunshine.log)."

################################################################################
# MENSAJE DE SALIDA
################################################################################

echo
echo "=============================================="
log_ok "Modo TV activado con éxito."
echo
echo "Ahora solamente abre Moonlight en tu dispositivo,"
echo "selecciona 'Desktop' y disfruta tu segundo monitor 😎"
echo "=============================================="
echo
