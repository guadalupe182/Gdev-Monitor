#!/usr/bin/env bash

# scripts/lib/helpers.sh

# Verifica si un comando está instalado en el sistema
check_command() {
    local cmd=$1
    if ! command -v "$cmd" >/dev/null 2>&1; then
        return 1
    fi
    return 0
}

# Verifica si la sesión actual es X11
is_x11() {
    if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
        return 0
    fi
    return 1
}
