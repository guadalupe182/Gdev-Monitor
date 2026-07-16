````markdown
# 📺 Gdev-Monitor (v2.0)

Convierte tu laptop Linux en una estación de transmisión automatizada. Crea un monitor virtual en Linux y transmite un escritorio extendido real utilizando **VKMS + Sunshine + Moonlight** de forma local o remota.

🚀 **Gdev-Monitor** automatiza la creación de pantallas virtuales, la configuración del firewall, la administración del audio del usuario y la carga de perfiles personalizados bajo entornos gráficos **X11**. Además, integra control remoto mediante Telegram y está preparado para futuras integraciones con asistentes de voz como Alexa.

---

# ✨ Características v2.0

- ✔ **Escritorio Extendido Real:** Configuración dinámica utilizando `xrandr --right-of` para extender el escritorio y mover ventanas libremente.
- ✔ **Monitor Virtual con VKMS:** Creación automática de pantallas virtuales mediante el módulo del kernel **VKMS**.
- ✔ **Streaming Integrado:** Compatible con **Sunshine** y clientes **Moonlight** para transmitir el escritorio con baja latencia.
- ✔ **Control Remoto por Telegram:** Bot integrado (`bot-control.py`) para ejecutar perfiles mediante comandos (`/mododev`, `/apagar`, `/netflix`, `/scrcpy`).
- ✔ **Aislamiento de Audio Seguro:** Manejo de sumideros virtuales con `pactl` directamente desde el espacio de usuario.
- ✔ **Elevación de Permisos Limpia:** Uso de `sudo` únicamente para tareas del sistema como carga de módulos o configuración del firewall.
- ✔ **Perfiles Personalizados:** Configuración dinámica mediante archivos independientes almacenados en `profiles/`.
- ✔ **Arquitectura Modular:** Scripts separados por responsabilidad para facilitar mantenimiento y escalabilidad.

---

# 📦 Requisitos

- Linux (Probado en Linux Mint / Ubuntu con X11)
- Python 3.x
- `python-telegram-bot`
- `xrandr`
- `modprobe` (VKMS)
- `ufw`
- `pactl` (PulseAudio o PipeWire)
- Sunshine
- Moonlight
- Git
- Make

---

# 📂 Estructura del Proyecto

```text
Gdev-Monitor/
├── bin/
│   └── gdev
├── profiles/
│   └── tv.conf
├── scripts/
│   ├── lib/
│   │   ├── logger.sh
│   │   └── spinner.sh
│   ├── bot-control.py
│   ├── laptop-mode.sh
│   ├── streaming-control.sh
│   ├── sunshine.sh
│   └── tv-mode.sh
├── Makefile
├── install.sh
├── LICENSE
└── README.md
```

---

# 🚀 Instalación

## Clonar el repositorio

```bash
git clone https://github.com/guadalupe182/Gdev-Monitor.git

cd Gdev-Monitor
```

---

## Dar permisos

```bash
chmod +x install.sh
chmod +x bin/gdev
chmod +x scripts/*.sh
```

---

## Ejecutar el instalador

```bash
./install.sh
```

El instalador configura automáticamente:

- VKMS
- Firewall (UFW)
- Scripts
- Permisos necesarios
- Entorno de ejecución

---

# 🚀 Uso

## Activar el modo TV

```bash
make start
```

o

```bash
gdev start
```

---

## Regresar al modo Laptop

```bash
make stop
```

o

```bash
gdev stop
```

---

# 🤖 Bot de Telegram

Ejecutar en segundo plano:

```bash
cd scripts

nohup python3 bot-control.py > /tmp/gdev-bot.log 2>&1 &
```

Consultar los registros:

```bash
tail -f /tmp/gdev-bot.log
```

---

# 📌 Comandos del Bot

| Comando | Descripción |
|----------|-------------|
| `/mododev` | Activa el escritorio extendido y redirecciona el audio hacia el perfil configurado. |
| `/apagar` | Restaura el modo Laptop y detiene el entorno virtual. |
| `/netflix` | Ejecuta el perfil optimizado para reproducción multimedia en TV. |
| `/scrcpy` | Inicia el control remoto para dispositivos Android mediante Scrcpy. |

---

# 🖥️ Flujo de Funcionamiento

```text
Laptop
   │
   ▼
Carga VKMS
   │
   ▼
Monitor Virtual
   │
   ▼
Configuración xrandr
   │
   ▼
Inicio de Sunshine
   │
   ▼
Moonlight
   │
   ▼
TV / Tablet / PC
```

---

# 🔊 Gestión de Audio

El proyecto administra automáticamente los dispositivos de audio mediante `pactl`, permitiendo:

- Redirección automática del audio.
- Compatibilidad con PulseAudio y PipeWire.
- Ejecución sin privilegios elevados.
- Restauración del estado original al finalizar.

---

# 🔐 Arquitectura de Permisos

```text
Usuario
│
├── Telegram Bot
├── Sunshine
├── Audio (pactl)
│
└── sudo
      ├── modprobe
      ├── ufw
      └── xrandr (cuando es requerido)
```

---

# 📚 Scripts Principales

### `tv-mode.sh`

- Crea el monitor virtual.
- Configura el escritorio extendido.
- Inicializa el audio.
- Prepara el entorno para Sunshine.

---

### `laptop-mode.sh`

- Elimina el monitor virtual.
- Restaura la pantalla principal.
- Restablece el audio original.

---

### `sunshine.sh`

Gestiona el ciclo de vida del servidor Sunshine.

- Inicio
- Reinicio
- Detención

---

### `streaming-control.sh`

Gestiona perfiles de streaming y automatizaciones específicas.

---

### `bot-control.py`

Bot de Telegram encargado de controlar todo el sistema mediante comandos remotos.

---

# 📊 Plan de Ciclo de Vida del Proyecto

El seguimiento de tareas (Backlog, To-Do, En Progreso y Finalizadas) se administra mediante **GitHub Projects**, permitiendo mantener sincronizados los sprints, los Issues y las Pull Requests sin duplicar información dentro del repositorio.

---

# 📄 Licencia

Este proyecto se distribuye bajo la licencia **MIT**.

Eres libre de utilizarlo, modificarlo y distribuirlo respetando los términos de la licencia.

---

# ❤️ Autor

Desarrollado por **GDEV**.

Proyecto enfocado en simplificar la creación de escritorios virtuales en Linux y su transmisión mediante **Sunshine + Moonlight**, incorporando automatización, perfiles de configuración y control remoto.
````

