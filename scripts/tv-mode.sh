#!/usr/bin/env bash
# scripts/tv-mode.sh

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
[[ -f "$ROOT_DIR/scripts/lib/logger.sh" ]] && source "$ROOT_DIR/scripts/lib/logger.sh"
[[ -f "$ROOT_DIR/scripts/lib/spinner.sh" ]] && source "$ROOT_DIR/scripts/lib/spinner.sh"

set -e
clear
echo "=============================================="
echo "        GDEV TV MODE v2.0 (Custom Profiles)"
echo "=============================================="
echo

# --- CARGAR PERFIL ---
PROFILE="$ROOT_DIR/profiles/tv.conf"
if [[ -f "$PROFILE" ]]; then
    source "$PROFILE"
    log_ok "Perfil cargado con éxito desde profiles/tv.conf"
else
    log_info "No se encontró perfil. Usando valores por defecto."
    RESOLUTION="1280x720"
    SCALE="1.0x1.0"
    DPI="96"
    MANAGE_AUDIO=false
fi

sudo true

# --- MANEJO DE AUDIO (NUEVO) ---
if [[ "$MANAGE_AUDIO" == true ]]; then
    log_info "Configurando sumidero de audio virtual para Sunshine..."
    # Crear un sumidero nulo para capturar el audio del sistema
    if ! pactl list short modules | grep -q "sink_name=$AUDIO_SINK_NAME"; then
        pactl load-module module-null-sink sink_name="$AUDIO_SINK_NAME" sink_properties=device.description="Sunshine_Audio_Stream" >/dev/null
    fi
    # Establecerlo como dispositivo por defecto
    pactl set-default-sink "$AUDIO_SINK_NAME"
    log_ok "Audio del sistema redirigido a Sunshine ($AUDIO_SINK_NAME)."
fi

# --- FIREWALL ---
log_info "Abriendo puertos en el firewall para Sunshine..."
sudo ufw allow 47984,47989,48010,8261,8262/tcp >/dev/null
sudo ufw allow 47998,47999,48000,48002,48010/udp >/dev/null

# --- PROPORCIONAR MONITOR ---
log_info "Cargando VKMS..."
sudo modprobe vkms &
show_spinner $!
echo ""

log_info "Esperando monitor virtual..."
for i in {1..10}; do
    if xrandr | grep -q "Virtual-1-1"; then break; fi
    sleep 1 & show_spinner $!; echo ""
done

# --- ESCALADO Y DPI (NUEVO) ---
log_info "Aplicando escalado ($SCALE) y DPI ($DPI) al monitor virtual..."
xrandr --output Virtual-1-1 --mode "$RESOLUTION" --scale "$SCALE" --dpi "$DPI" --right-of eDP-1
log_ok "Pantalla virtual configurada correctamente."

echo
log_info "Lanzando servidor Sunshine..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/sunshine.sh" > /tmp/sunshine.log 2>&1 &
log_ok "Sunshine corriendo de fondo."

echo "=============================================="
log_ok "¡Modo TV con Perfil Avanzado Activo! 😎"
echo "=============================================="
