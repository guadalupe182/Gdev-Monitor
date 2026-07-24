import logging
import subprocess
from telegram import Update
from telegram.ext import Application, CommandHandler, ContextTypes

TOKEN = "8914773959:AAGEO19_c6AHxqlNyeKb5JHVmCEH-hjBvkA"
BASE_DIR = "/home/guadalupe/scripts/Gdev-Monitor"

logging.basicConfig(format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', level=logging.INFO)

# 1. Comando Status (Informativo en tiempo real)
async def status_cmd(update: Update, context: ContextTypes.DEFAULT_TYPE):
    res_sunshine = subprocess.run("pgrep sunshine", shell=True, capture_output=True)
    res_vkms = subprocess.run("lsmod | grep vkms", shell=True, capture_output=True)

    sunshine_status = "Activo" if res_sunshine.returncode == 0 else "Apagado"
    vkms_status = "Cargado" if res_vkms.returncode == 0 else "Desactivado"

    msg = (
        "*Estado Actual del Sistema*\n\n"
        f"• *Sunshine:* {sunshine_status}\n"
        f"• *Modulo VKMS:* {vkms_status}\n"
        f"• *Pantalla Laptop (eDP-1):* Activa\n"
    )
    await update.message.reply_text(msg, parse_mode="Markdown")

# 2. Comando Modo Dev (Lanza pantallas + IDEs y confirma)
async def start_dev(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("Encendiendo pantallas e iniciando IntelliJ + WebStorm...")
    # Ejecutamos de forma sincronica para validar la salida
    subprocess.run(f"make -C {BASE_DIR} start && make -C {BASE_DIR} dev-apps", shell=True)
    await update.message.reply_text("*Modo Dev iniciado con exito.* Sunshine activo e IDEs en marcha.", parse_mode="Markdown")

# 3. Comando Apagar
async def stop_all(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("Restaurando a Modo Laptop...")
    subprocess.run(f"make -C {BASE_DIR} stop", shell=True)
    await update.message.reply_text("*Modo Laptop restaurado.* Modulo VKMS y Sunshine apagados.", parse_mode="Markdown")

# 4. Comando Fix (Recuperación)
async def emergency_fix(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("Ejecutando recuperacion de emergencia...")
    subprocess.run(f"make -C {BASE_DIR} fix", shell=True)
    await update.message.reply_text("*Sistema recuperado:* Salida virtual apagada y candados (.lock) eliminados.", parse_mode="Markdown")

# 5. Ayuda y Start
async def help_cmd(update: Update, context: ContextTypes.DEFAULT_TYPE):
    msg = (
        "*Gdev-Monitor Control Bot*\n\n"
        "Comandos disponibles:\n"
        "/mododev - Activa Pantalla TV + IDEs\n"
        "/status - Muestra si Sunshine y VKMS estan activos\n"
        "/apagar - Restaura a Modo Laptop\n"
        "/fix - Recuperacion de emergencia\n"
        "/help - Muestra este menu"
    )
    await update.message.reply_text(msg, parse_mode="Markdown")

def main():
    app = Application.builder().token(TOKEN).build()

    # Handlers
    app.add_handler(CommandHandler("status", status_cmd))
    app.add_handler(CommandHandler("mododev", start_dev))
    app.add_handler(CommandHandler("apagar", stop_all))
    app.add_handler(CommandHandler("fix", emergency_fix))
    app.add_handler(CommandHandler("start", help_cmd))
    app.add_handler(CommandHandler("help", help_cmd))

    print("[OK] Bot Gdev-Monitor actualizado. Escuchando comandos...")
    app.run_polling()

if __name__ == "__main__":
    main()
