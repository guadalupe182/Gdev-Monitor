# Gdev-Monitor Automation Makefile
.PHONY: init doctor start stop fmt lint test install uninstall clean bot-start bot-stop dev-apps fix

PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
SCRIPT_DIR = scripts
PROFILE_DIR = profiles

all: doctor

init:
	@echo "[INFO] Inicializando entorno de desarrollo..."
	chmod +x $(SCRIPT_DIR)/*.sh
	@echo "[OK] Permisos aplicados."

doctor:
	@bash $(SCRIPT_DIR)/display.sh --check-env
	@bash $(SCRIPT_DIR)/display.sh --check-gpu
	@echo "[OK] Diagnóstico completo 🩺"

# Arranca Modo TV (pantalla extendida) + Bot
start: bot-start
	@bash $(SCRIPT_DIR)/tv-mode.sh

# Restaura a Laptop Mode
stop:
	@bash $(SCRIPT_DIR)/laptop-mode.sh

# Modo Dev: Lanza los IDEs (WebStorm e IntelliJ) y configura pantalla
dev-apps:
	@echo "[INFO] Lanzando entornos de desarrollo..."
	@flatpak run com.jetbrains.WebStorm >/dev/null 2>&1 &
	@flatpak run com.jetbrains.IntelliJ-IDEA-Ultimate >/dev/null 2>&1 &

# Comando de Recuperación Segura (FIX) sin matar la sesión gráfica
fix:
	@echo "[INFO] Ejecutando recuperación de emergencia..."
	@xrandr --output Virtual-1-1 --off 2>/dev/null || true
	@xrandr --output eDP-1 --auto
	@sudo modprobe -r vkms 2>/dev/null || true
	@pkill -9 -f sunshine 2>/dev/null || true
	@find ~/.var/app/com.jetbrains.*/ -name "*.lock" -delete 2>/dev/null || true
	@echo "[OK] Sistema recuperado y listo."

# Control del Bot de Telegram
bot-start:
	@echo "[INFO] Iniciando Bot de Telegram..."
	@pgrep -f "bot-control.py" >/dev/null || (python3 scripts/bot-control.py > /tmp/gdev-bot.log 2>&1 &)

bot-stop:
	@echo "[INFO] Deteniendo Bot..."
	@pkill -f "bot-control.py" || true

fmt:
	@if command -v shfmt >/dev/null 2>&1; then shfmt -w $(SCRIPT_DIR)/*.sh; fi

lint:
	@if command -v shellcheck >/dev/null 2>&1; then shellcheck $(SCRIPT_DIR)/*.sh; fi

clean:
	rm -f /tmp/sunshine.log /tmp/gdev-bot.log
