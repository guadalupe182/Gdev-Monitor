#!/usr/bin/env bash

# scripts/lib/logger.sh

# 1. Importamos de forma segura el módulo de colores usando la ruta relativa del proyecto
LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$LIB_DIR/colors.sh" ]]; then
    source "$LIB_DIR/colors.sh"
else
    echo "Error: No se pudo cargar el módulo de colores en $LIB_DIR/colors.sh" >&2
    exit 1
fi

# 2. Funciones del Logger
log_ok() {
    echo -e "${COLOR_GREEN}[OK]${COLOR_RESET} $*"
}

log_info() {
    echo -e "${COLOR_BLUE}[INFO]${COLOR_RESET} $*"
}

log_warn() {
    echo -e "${COLOR_YELLOW}[WARN]${COLOR_RESET} $*"
}

log_error() {
    echo -e "${COLOR_RED}[ERROR]${COLOR_RESET} $*" >&2
}
