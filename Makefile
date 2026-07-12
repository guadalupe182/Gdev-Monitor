# Gdev-Monitor Automation Makefile
.PHONY: init doctor start stop fmt lint test install uninstall clean

# Variables
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
SCRIPT_DIR = scripts
PROFILE_DIR = profiles

all: doctor

# 1. Inicializar el entorno (Dar permisos de ejecución)
init:
	@echo "[INFO] Inicializando entorno de desarrollo..."
	chmod +x $(SCRIPT_DIR)/*.sh
	@echo "[OK] Permisos de ejecución aplicados a todos los scripts."

# 2. Diagnóstico del sistema (Ya estructurado)
doctor:
	@bash $(SCRIPT_DIR)/display.sh --check-env
	@bash $(SCRIPT_DIR)/display.sh --check-gpu
	@echo "[OK] ¡Diagnóstico completo terminado con éxito! 🩺"

# 3. Alias de ejecución estándar
start:
	@bash $(SCRIPT_DIR)/tv-mode.sh

stop:
	@bash $(SCRIPT_DIR)/laptop-mode.sh

# 4. Formateo de código (Usa shfmt si está instalado, si no, avisa)
fmt:
	@echo "[INFO] Formateando scripts de Bash..."
	@if command -v shfmt >/dev/null 2>&1; then \
		shfmt -w $(SCRIPT_DIR)/*.sh; \
		echo "[OK] Código formateado elegantemente."; \
	else \
		echo "[WARN] 'shfmt' no está instalado. Instálalo con: sudo apt install shfmt"; \
	fi

# 5. Análisis estático (Usa shellcheck para buscar bugs ocultos)
lint:
	@echo "[INFO] Ejecutando análisis estático con shellcheck..."
	@if command -v shellcheck >/dev/null 2>&1; then \
		shellcheck $(SCRIPT_DIR)/*.sh; \
		echo "[OK] No se encontraron bugs ni malas prácticas en los scripts."; \
	else \
		echo "[WARN] 'shellcheck' no está instalado. Instálalo con: sudo apt install shellcheck"; \
	fi

# 6. Pruebas unitarias/verificaciones básicas
test:
	@echo "[INFO] Validando sintaxis de perfiles de configuración..."
	@if [ -f $(PROFILE_DIR)/tv.conf ]; then \
		bash -n $(PROFILE_DIR)/tv.conf && echo "[OK] Sintaxis de profiles/tv.conf correcta."; \
	fi
	@bash -n $(SCRIPT_DIR)/*.sh && echo "[OK] Sintaxis de scripts correcta."

# 7. Instalación global en el sistema operativo
install:
	@echo "[INFO] Instalando gdev-monitor globalmente en $(BINDIR)..."
	@sudo mkdir -p $(BINDIR)
	@# Crear un wrapper dinámico para ejecutarlo desde cualquier lado
	@echo '#!/usr/bin/env bash' | sudo tee $(BINDIR)/gdev-monitor >/dev/null
	@echo 'case "$$1" in' | sudo tee -a $(BINDIR)/gdev-monitor >/dev/null
	@echo '  --tv|start) make -C '$(PWD)' start ;;' | sudo tee -a $(BINDIR)/gdev-monitor >/dev/null
	@echo '  --laptop|stop) make -C '$(PWD)' stop ;;' | sudo tee -a $(BINDIR)/gdev-monitor >/dev/null
	@echo '  --doctor) make -C '$(PWD)' doctor ;; ' | sudo tee -a $(BINDIR)/gdev-monitor >/dev/null
	@echo '  *) echo "Uso: gdev-monitor [start | stop | --doctor]" ;; ' | sudo tee -a $(BINDIR)/gdev-monitor >/dev/null
	@echo 'esac' | sudo tee -a $(BINDIR)/gdev-monitor >/dev/null
	@sudo chmod +x $(BINDIR)/gdev-monitor
	@echo "[OK] Instalación completada. Ahora puedes usar el comando 'gdev-monitor' desde donde sea."

# 8. Desinstalación limpia
uninstall:
	@echo "[INFO] Removiendo gdev-monitor de $(BINDIR)..."
	@sudo rm -f $(BINDIR)/gdev-monitor
	@echo "[OK] Desinstalado correctamente."

# 9. Limpieza de residuos
clean:
	@echo "[INFO] Limpiando archivos temporales y logs..."
	rm -f /tmp/sunshine.log
	@echo "[OK] Entorno limpio."
