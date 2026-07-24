````markdown
# 📺 Gdev-Monitor (v2.0)

Convierte tu laptop Linux en una estación de transmisión automatizada. Crea un monitor virtual en Linux y transmite un escritorio extendido real utilizando **VKMS + Sunshine + Moonlight** de forma local o remota.

🚀 **Gdev-Monitor** automatiza la creación de pantallas virtuales, la configuración del firewall, la administración del audio del usuario y la carga de perfiles personalizados bajo entornos gráficos **X11**. Además, integra control remoto mediante Telegram con capacidades de auto-recuperación y lanzamiento automatizado de entornos de desarrollo (IDEs).

---

# ✨ Características v2.0

- ✔ **Escritorio Extendido Real:** Configuración dinámica utilizando `xrandr --right-of` para extender el escritorio y mover ventanas libremente.
- ✔ **Monitor Virtual con VKMS:** Creación automática de pantallas virtuales mediante el módulo del kernel **VKMS**.
- ✔ **Streaming Integrado:** Compatible con **Sunshine** y clientes **Moonlight** para transmitir el escritorio con baja latencia.
- ✔ **Control Remoto por Telegram:** Bot integrado (`bot-control.py`) para ejecutar perfiles, consultar estado y aplicar recuperación de emergencia.
- ✔ **Arranque de Entorno Dev:** Carga automática de IDEs (**WebStorm** e **IntelliJ IDEA**) al activar el modo desarrollo.
- ✔ **Mecanismo de Auto-Recuperación (`/fix`):** Limpieza de pantallas colgadas y archivos `.lock` sin reiniciar el servidor gráfico.
- ✔ **Aislamiento de Audio Seguro:** Manejo de sumideros virtuales mediante `pactl` directamente desde el espacio de usuario.
- ✔ **Elevación de Permisos Limpia:** Uso de reglas `sudoers` sin contraseña para `modprobe`, `xrandr` y administración de servicios.
- ✔ **Perfiles Personalizados:** Configuración dinámica mediante archivos independientes almacenados en `profiles/` (por ejemplo `tv.conf`).

---

# 🏗️ Arquitectura

```text
               ┌────────────────────────────┐
               │       Telegram Bot         │
               │     bot-control.py         │
               └──────────────┬─────────────┘
                              │
                              ▼
                    Streaming Controller
                              │
        ┌─────────────────────┼──────────────────────┐
        ▼                     ▼                      ▼
   VKMS Virtual        Sunshine Server         Audio Routing
     Display             Streaming           PulseAudio/PipeWire
        │                     │                      │
        └──────────────► Moonlight ◄─────────────────┘
```

---

# 📦 Requisitos

## Sistema Operativo

- Linux Mint 22+
- Ubuntu 22.04+
- Cualquier distribución basada en Debian compatible con X11

## Dependencias

- Python 3.x
- `python-telegram-bot`
- `xrandr`
- `modprobe`
- `ufw`
- `pactl`
- `Sunshine`
- `Moonlight`
- Git
- Make

---

# 📂 Estructura del Proyecto

```text
Gdev-Monitor/
├── bin/
│   └── gdev
│
├── profiles/
│   └── tv.conf
│
├── scripts/
│   ├── lib/
│   │   ├── logger.sh
│   │   └── spinner.sh
│   │
│   ├── bot-control.py
│   ├── laptop-mode.sh
│   ├── streaming-control.sh
│   ├── sunshine.sh
│   └── tv-mode.sh
│
├── Makefile
├── install.sh
├── LICENSE
└── README.md
```

---

# 🚀 Instalación

## 1. Clonar el repositorio

```bash
git clone https://github.com/guadalupe182/Gdev-Monitor.git

cd Gdev-Monitor
```

---

## 2. Dar permisos

```bash
chmod +x install.sh
chmod +x bin/gdev
chmod +x scripts/*.sh
```

---

## 3. Ejecutar el instalador

```bash
./install.sh
```

El instalador configura automáticamente:

- ✔ VKMS
- ✔ Firewall (UFW)
- ✔ Scripts
- ✔ Makefile
- ✔ Acceso global mediante `gdev`
- ✔ Reglas sudoers necesarias
- ✔ Configuración inicial

---

# 🚀 Uso desde Terminal

## Activar Modo TV

```bash
make start
```

o

```bash
gdev start
```

---

## Abrir entorno de desarrollo

```bash
make dev-apps
```

Abre automáticamente:

- IntelliJ IDEA
- WebStorm

---

## Volver al modo Laptop

```bash
make stop
```

---

## Recuperación de emergencia

```bash
make fix
```

Este comando:

- elimina archivos `.lock`
- reinicia VKMS
- reconfigura pantallas
- recupera Sunshine
- limpia estados inconsistentes

---

# 🤖 Bot de Telegram

## Comandos disponibles

| Comando | Descripción |
|----------|-------------|
| `/mododev` | Activa el escritorio extendido e inicia WebStorm + IntelliJ IDEA. |
| `/status` | Consulta el estado del sistema. |
| `/apagar` | Restaura el modo Laptop y detiene Sunshine. |
| `/fix` | Ejecuta el mecanismo de recuperación. |
| `/help` | Muestra todos los comandos disponibles. |

---

## Ejecutar el bot

```bash
make bot-start
```

---

## Consultar registros

```bash
tail -f /tmp/gdev-bot.log
```

---

# 🔊 Gestión de Audio

Gdev-Monitor administra automáticamente el audio utilizando `pactl`.

Características:

- Redirección automática hacia el monitor virtual.
- Compatible con PulseAudio.
- Compatible con PipeWire.
- Sin ejecutar procesos como root.
- Restauración automática al finalizar.

---

# 📺 Flujo de Funcionamiento

```text
Usuario
   │
   ▼
make start
   │
   ▼
Carga VKMS
   │
   ▼
Crea Monitor Virtual
   │
   ▼
Configura xrandr
   │
   ▼
Inicia Sunshine
   │
   ▼
Configura Audio
   │
   ▼
Esperando Moonlight
```

---

# ⚙️ Configuración

Los perfiles se almacenan en:

```text
profiles/
```

Ejemplo:

```text
profiles/
└── tv.conf
```

Cada perfil puede definir:

- resolución
- posición del monitor
- audio
- aplicaciones
- comportamiento personalizado

---

# 🛠️ Comandos Make

| Comando | Acción |
|----------|--------|
| `make start` | Activa el modo TV. |
| `make stop` | Regresa al modo Laptop. |
| `make fix` | Recuperación automática. |
| `make dev-apps` | Inicia los IDEs. |
| `make bot-start` | Ejecuta el bot de Telegram. |

---

# 🔒 Seguridad

El proyecto utiliza reglas específicas de **sudoers** para permitir únicamente los comandos necesarios, evitando el uso de privilegios elevados de forma permanente.

Los permisos se limitan a:

- `modprobe`
- `xrandr`
- `systemctl`
- administración de Sunshine
- gestión de pantallas virtuales

---

# 🚧 Roadmap

## v2.x

- [x] VKMS automático
- [x] Integración con Sunshine
- [x] Control mediante Telegram
- [x] Recuperación automática
- [x] Lanzamiento de IDEs
- [x] Gestión de audio

## Próximamente

- [ ] Integración con Alexa
- [ ] Dashboard Web
- [ ] API REST
- [ ] Múltiples perfiles
- [ ] Multi-monitor
- [ ] Detección automática de pantallas
- [ ] Instalación mediante paquetes `.deb`
- [ ] Actualizaciones automáticas

---

# 🤝 Contribuciones

Las contribuciones son bienvenidas.

Puedes colaborar mediante:

- Pull Requests
- Issues
- Mejoras de documentación
- Nuevas funcionalidades
- Reportes de errores

---

# 📄 Licencia

Este proyecto se distribuye bajo la licencia **MIT**.

Consulta el archivo:

```text
LICENSE
```

---

# ❤️ Autor

Desarrollado con ❤️ por **GDEV Software Solutions**.

Si este proyecto te resulta útil, considera darle una ⭐ al repositorio y compartirlo con la comunidad.
````

