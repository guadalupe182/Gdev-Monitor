#!/usr/bin/env bash
# scripts/laptop-mode.sh

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
[[ -f "$ROOT_DIR/scripts/lib/logger.sh" ]] && source "$ROOT_DIR/scripts/lib/logger.sh"

clear
echo "=============================================="
echo "       GDEV LAPTOP MODE v1.0"
echo "=============================================="
echo

log_info "Apagando servidor Sunshine..."
pkill -f sunshine || log_info "Sunshine ya estaba apagado."

# Asegurar privilegios sudo desde el inicio
sudo true

# --- NUEVO: CERRAR FIREWALL ---
log_info "Cerrando puertos en el firewall..."
sudo ufw delete allow 47984,47989,48010,8261,8262/tcp >/dev/null
sudo ufw delete allow 47998,47999,48000,48002,48010/udp >/dev/null
log_ok "Puertos del firewall cerrados y protegidos."

if xrandr | grep -q "Virtual-1-1"; then
    log_info "Desactivando monitor virtual Virtual-1-1..."
    xrandr --output Virtual-1-1 --off
    log_ok "Monitor virtual desactivado por xrandr."
fi

log_info "Removiendo módulo VKMS de la memoria..."
# Mandamos el modprobe -r a segundo plano para que intente limpiar
# en cuanto x11 parpadee y libere los recursos, sin bloquear el script

(
    for i in {1..5}; do
        if sudo modprobe -r vkms 2>/dev/null; then
            break
        fi
        sleep 1
    done
) &
# Imprimimos el éxito directo ya que el hardware se desconectó por xrandr
log_ok "VKMS desenganchado del entorno gráfico"
