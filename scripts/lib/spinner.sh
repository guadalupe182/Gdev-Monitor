#!/usr/bin/env bash

# scripts/lib/spinner.sh

# Importar colores si no están cargados
LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
[[ -f "$LIB_DIR/colors.sh" ]] && source "$LIB_DIR/colors.sh"

show_spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'

    # Ocultar el cursor en la terminal de forma correcta
    tput civis

    echo -n " "
    while kill -0 "$pid" 2>/dev/null; do
        local temp=${spinstr#?}
        printf "${COLOR_BLUE}%c${COLOR_RESET}" "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b"
    done

    # Restaurar el cursor al terminar
    tput cnorm
    printf " \b"
}
