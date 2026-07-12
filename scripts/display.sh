#!/usr/bin/env bash
# scripts/display.sh

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
[[ -f "$ROOT_DIR/scripts/lib/logger.sh" ]] && source "$ROOT_DIR/scripts/lib/logger.sh"

# Función para el Sprint 2: Detección del Sistema y Comprobaciones
check_environment() {
    log_info "Verificando entorno del sistema operativo..."

    # 1. Validar si estamos en X11
    if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
        log_ok "Servidor gráfico correcto: X11 detectado."
    else
        log_error "Entorno actual es '$XDG_SESSION_TYPE'. Este monitor virtual requiere X11."
    fi

    # 2. Validar herramientas requeridas
    log_info "Comprobando dependencias esenciales..."
    local deps=("xrandr" "modprobe" "ufw" "pkill")
    local missing=0

    for dep in "${deps[@]}"; do
        if command -v "$dep" >/dev/null 2>&1; then
            log_ok "Dependencia encontrada: $dep"
        else
            log_error "Dependencia FALTANTE: $dep. Por favor instálala."
            missing=$((missing + 1))
        fi
    done

    if [[ $missing -eq 0 ]]; then
        log_ok "🩺 Todas las comprobaciones de entorno pasaron con éxito."
    else
        log_error "Se encontraron $missing problemas en el entorno."
        return 1
    fi
}

# Función para el Sprint 2: Detección de Hardware de GPU
check_gpu() {
    log_info "Iniciando detección de hardware gráfico (GPU)..."

    # Obtener info de las tarjetas mediante lspci de forma silenciosa
    local gpu_info
    gpu_info=$(lspci | grep -E "VGA|3D" | tr '[:upper:]' '[:lower:]')

    log_info "Dispositivos de video encontrados:"
    echo "$gpu_info" | while read -r line; do
        echo "  -> $line"
    done

    # Analizar marcas específicas
    if echo "$gpu_info" | grep -q "nvidia"; then
        log_ok "GPU Detectada: 🟢 NVIDIA"
        # Verificar si los drivers propietarios están cargados
        if lsmod | grep -q "nvidia"; then
            log_ok "Driver activo: Drivers propietarios de NVIDIA cargados correctamente."
        else
            log_error "Driver pasivo: Se detectó hardware NVIDIA pero no se encontraron sus módulos cargados."
        fi
    elif echo "$gpu_info" | grep -q "intel"; then
        log_ok "GPU Detectada: 🔵 INTEL (Gráficos integrados)"
    elif echo "$gpu_info" | grep -q "amd|ati"; then
        log_ok "GPU Detectada: 🔴 AMD / ATI"
    else
        log_error "No se pudo clasificar el proveedor de la GPU. Revisar salida de lspci."
    fi
}

# Manejo de parámetros de entrada
case "$1" in
    --check-env)
        check_environment
        ;;
    --check-gpu)
        check_gpu
        ;;
    *)
        echo "Gdev-Monitor Display CLI"
        echo "Uso: $0 [--check-env | --check-gpu]"
        exit 1
        ;;
esac
