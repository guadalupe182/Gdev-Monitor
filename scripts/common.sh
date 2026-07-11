#!/usr/bin/env bash

set -euo pipefail

info() {
    printf "\033[1;34m[INFO]\033[0m %s\n" "$*"
}

success() {
    printf "\033[1;32m[SUCCESS]\033[0m %s\n" "$*"
}

warn() {
    printf "\033[1;33m[WARN]\033[0m %s\n" "$*"
}

error() {
    printf "\033[1;31m[ERROR]\033[0m %s\n" "$*" >&2
}

require_command() {
    command -v "$1" >/dev/null 2>&1 || {
        error "Missing dependency: $1"
        exit 1
    }
}
