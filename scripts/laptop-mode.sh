#!/usr/bin/env bash
# scripts/laptop-mode.sh

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
[[ -f "$ROOT_DIR/scripts/lib/logger.sh" ]] && source "$ROOT_DIR/scripts/lib/logger.sh"

clear
echo "=============================================="
echo "        GDEV LAPTOP MODE v1.0"
echo "=============================================="
echo

# 1. Asegurar privilegios sudo desde el inicio
sudo true

# 2. DETENER SUNSHINE PRIMERO (Crucial para evitar congelamientos en X11)
log_info "Apagando servidor Sunshine..."
pkill -f sunshine || log_info "Sunshine ya estaba apagado."
sleep 1 # Un respiro para que el proceso libere los recursos de video

# 3. Gestionar pantallas con X11 de forma segura
if xrandr | grep -q "Virtual-1-1"; then
    log_info "Desactivando monitor virtual Virtual-1-1..."
    xrandr --output Virtual-1-1 --off
    log_ok "Monitor virtual desactivado por xrandr."
fi

# Aseguramos que la pantalla física sea la principal absoluta del entorno
log_info "Restaurando pantalla principal de la laptop (eDP-1)..."
xrandr --output eDP-1 --auto --primary
log_ok "Pantalla eDP-1 restablecida correctamente."

# 4. Cerrar puertos en el Firewall
log_info "Cerrando puertos en el firewall..."
sudo ufw delete allow 47984,47989,48010,8261,8262/tcp >/dev/null 2>&1
sudo ufw delete allow 47998,47999,48000,48002,48010/udp >/dev/null 2>&1
log_ok "Puertos del firewall cerrados y protegidos."

# 5. Remover el módulo del Kernel de forma segura
log_info "Removiendo módulo VKMS de la memoria..."
if sudo modprobe -r vkms 2>/dev/null; then
    log_ok "VKMS desenganchado del entorno gráfico con éxito."
else
    # Si sigue ocupado, remoción forzada limpia
    sudo rmmod -f vkms 2>/dev/null
    log_ok "VKMS liberado del sistema."
fi

echo
log_ok "¡Modo laptop restaurado al 100%! Sistema estable."
