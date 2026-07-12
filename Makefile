# Variables de rutas
SCRIPTS_DIR := scripts
LIB_DIR     := $(SCRIPTS_DIR)/lib

.PHONY: tv laptop doctor check-sys check-gpu help

# ==============================================================================
# SPRINT 1: MODOS DE PANTALLA
# ==============================================================================

tv:
	@bash $(SCRIPTS_DIR)/tv-mode.sh

laptop:
	@bash $(SCRIPTS_DIR)/laptop-mode.sh

# ==============================================================================
# SPRINT 2: DIAGNÓSTICO Y COMPROBACIONES (El Target Fino)
# ==============================================================================

## doctor: Corre todas las comprobaciones de salud del sistema de un solo golpe
doctor: check-sys check-gpu
	@bash -c 'source $(LIB_DIR)/logger.sh && log_ok "¡Diagnóstico completo terminado con éxito! 🩺"'

## check-sys: Verifica el entorno base, X11/Wayland y dependencias del sistema
check-sys:
	@bash -c 'source $(LIB_DIR)/logger.sh && log_info "Iniciando detección del sistema..."'
	@bash $(SCRIPTS_DIR)/display.sh --check-env || true

## check-gpu: Identifica las GPUs activas (Intel/Nvidia/AMD) y sus drivers
check-gpu:
	@bash -c 'source $(LIB_DIR)/logger.sh && log_info "Iniciando detección de GPU..."'
	@bash $(SCRIPTS_DIR)/display.sh --check-gpu || true

# ==============================================================================
# UTILERÍAS
# ==============================================================================

help:
	@echo "Comandos disponibles en Gdev-Monitor:"
	@echo "  make tv        - Activa el modo TV (VKMS + Sunshine)"
	@echo "  make laptop    - Revierte al modo Laptop estándar"
	@echo "  make doctor    - Corre el diagnóstico completo del sistema (Sprint 2)"
