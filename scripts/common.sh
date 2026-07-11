#!/usr/bin/env bash

set -euo pipefail

########################################
# Project
########################################

readonly GDEV_NAME="Gdev Monitor"
readonly GDEV_VERSION="0.1.0"

########################################
# Configuration
########################################

: "${GDEV_DEBUG:=0}"
: "${GDEV_LOG_TIME:=1}"

########################################
# Colors
########################################

readonly COLOR_RESET="\033[0m"

readonly COLOR_BLUE="\033[1;34m"
readonly COLOR_GREEN="\033[1;32m"
readonly COLOR_YELLOW="\033[1;33m"
readonly COLOR_RED="\033[1;31m"
readonly COLOR_GRAY="\033[90m"

########################################
# Private Functions
########################################

_timestamp() {
    date +"%H:%M:%S"
}

_log() {

    local color="$1"
    local level="$2"

    shift 2

    local prefix=""

    if [[ "$GDEV_LOG_TIME" == "1" ]]; then
        prefix="[$(_timestamp)] "
    fi

    printf "%b%s[%s]%b %s\n" \
        "$color" \
        "$prefix" \
        "$level" \
        "$COLOR_RESET" \
        "$*"
}

########################################
# Public Logger API
########################################

info() {
    _log "$COLOR_BLUE" "INFO" "$@"
}

success() {
    _log "$COLOR_GREEN" "SUCCESS" "$@"
}

warn() {
    _log "$COLOR_YELLOW" "WARN" "$@"
}

error() {
    _log "$COLOR_RED" "ERROR" "$@" >&2
}

debug() {

    [[ "$GDEV_DEBUG" == "1" ]] || return 0

    _log "$COLOR_GRAY" "DEBUG" "$@"
}

########################################
# Helpers
########################################

require_command() {

    command -v "$1" >/dev/null 2>&1 || {
        error "Missing dependency: $1"
        exit 1
    }
}

require_root() {

    if [[ "$EUID" -ne 0 ]]; then
        error "This operation requires root privileges."
        exit 1
    fi
}

########################################
# Banner
########################################

banner() {

cat <<EOF

==========================================
        $GDEV_NAME v$GDEV_VERSION
==========================================

EOF

}
