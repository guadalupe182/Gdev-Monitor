import logging
import subprocess
from telegram import Update
from telegram.ext import Application, CommandHandler, ContextTypes

# Token extraído de BotFather
TOKEN = "8914773959:AAGEO19_c6AHxqlNyeKb5JHVmCEH-hjBvkA"

logging.basicConfig(format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', level=logging.INFO)

async def start_dev(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("🚀 ¡Entendido! Iniciando Modo Dev en la Acer Aspire...")
    subprocess.Popen("make -C /home/guadalupe/scripts/Gdev-Monitor start", shell=True)

async def stop_dev(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("💻 Entendido. Restaurando pantallas a Modo Laptop...")
    subprocess.Popen("make -C /home/guadalupe/scripts/Gdev-Monitor stop", shell=True)

async def start_netflix(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("🎬 Transmitiendo Netflix a la TV...")
    subprocess.Popen("make -C /home/guadalupe/scripts/Gdev-Monitor streaming APP=netflix", shell=True)

async def start_scrcpy(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("📱 Abriendo control de pantalla flotante con Scrcpy...")
    subprocess.Popen("make -C /home/guadalupe/scripts/Gdev-Monitor scrcpy", shell=True)

def main():
    app = Application.builder().token(TOKEN).build()

    # Comandos que vas a mandar por chat
    app.add_handler(CommandHandler("mododev", start_dev))
    app.add_handler(CommandHandler("apagar", stop_dev))
    app.add_handler(CommandHandler("netflix", start_netflix))
    app.add_handler(CommandHandler("scrcpy", start_scrcpy))

    print("[OK] Bot de Control Gdev en marcha. Esperando comandos por chat...")
    app.run_polling()

if __name__ == "__main__":
    main()
