#!/usr/bin/env bash
# scripts/tv-mode.sh

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
[[ -f "$ROOT_DIR/scripts/lib/logger.sh" ]] && source "$ROOT_DIR/scripts/lib/logger.sh"
[[ -f "$ROOT_DIR/scripts/lib/spinner.sh" ]] && source "$ROOT_DIR/scripts/lib/spinner.sh"

set -e
clear
echo "=============================================="
echo "        GDEV TV MODE v1.0"
echo "=============================================="
echo

log_info "Verificando entorno y xrandr..."
[[ "$XDG_SESSION_TYPE" != "x11" ]] && { log_error "Sólo funciona en X11."; exit 1; }
command -v xrandr >/dev/null || { log_error "xrandr no instalado."; exit 1; }

# Forzar sudo al inicio para el firewall y el modprobe
sudo true

# --- NUEVO: HABILITAR FIREWALL ---
log_info "Abriendo puertos en el firewall para Sunshine..."
sudo ufw allow 47984,47989,48010,8261,8262/tcp >/dev/null
sudo ufw allow 47998,47999,48000,48002,48010/udp >/dev/null
log_ok "Puertos del firewall abiertos."

log_info "Cargando VKMS..."
sudo modprobe vkms &
show_spinner $!
echo ""

log_info "Esperando monitor virtual..."
for i in {1..10}; do
    if xrandr | grep -q "Virtual-1-1"; then
        log_ok "Monitor detectado."
        break
    fi
    sleep 1 &
    show_spinner $!
done

if ! xrandr | grep -q "Virtual-1-1"; then
    log_error "No apareció Virtual-1-1"
    exit 1
fi

log_info "Configurando resolución..."
xrandr --output Virtual-1-1 --mode 1280x720 --right-of eDP-1
log_ok "Resolución aplicada (1280x720)."

echo
log_info "Lanzando servidor Sunshine en segundo plano..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/sunshine.sh" > /tmp/sunshine.log 2>&1 &
log_ok "Sunshine corriendo (Logs en /tmp/sunshine.log)."

echo
echo "=============================================="
log_ok "Modo TV activado con éxito. 😎"
echo "=============================================="
