Aquí está el `README.md` completo, listo para copiar y pegar en un solo archivo.

````markdown
# 📺 GDEV TV Mode

Convierte tu laptop en una estación de transmisión automatizada. Crea un monitor virtual en Linux y transmite una segunda pantalla física real utilizando **VKMS + Sunshine + Moonlight** con un solo comando.

🚀 **GDEV TV Mode** nace para resolver de forma automática el tedioso proceso de configurar pantallas virtuales, ajustar el firewall, redireccionar audio y establecer resoluciones personalizadas en servidores gráficos X11.

---

# ✨ Características

- ✔ Creación automática de monitor virtual mediante **VKMS**.
- ✔ Configuración dinámica utilizando **xrandr**.
- ✔ Resoluciones, escalado y DPI personalizables.
- ✔ Redirección automática del audio hacia Sunshine.
- ✔ Restauración automática del audio al modo Laptop.
- ✔ Apertura y cierre automático de puertos mediante **UFW**.
- ✔ Diagnóstico completo del sistema (`doctor`).
- ✔ Administración completa mediante una sola CLI.
- ✔ Scripts modulares y fáciles de extender.

---

# 📦 Requisitos

- Linux Mint 22.x (recomendado)
- Ubuntu 22.04+
- X11 (Wayland no soportado actualmente)
- Bash
- xrandr
- modprobe
- ufw
- pactl (PulseAudio o PipeWire)
- Sunshine
- Moonlight

---

# 📂 Estructura del proyecto

```text
gdev-tv-mode/
├── assets/
│   └── screenshots/
│
├── bin/
│   └── gdev
│
├── config/
│   └── default.conf
│
├── docs/
│   ├── INSTALL.md
│   ├── CONFIG.md
│   └── TROUBLESHOOTING.md
│
├── scripts/
│   ├── display.sh
│   ├── laptop-mode.sh
│   └── tv-mode.sh
│
├── src/
│
├── tests/
│
├── Makefile
├── install.sh
├── uninstall.sh
└── README.md
```

---

# 🚀 Instalación

Clona el repositorio:

```bash
git clone https://github.com/TU-USUARIO/gdev-tv-mode.git
```

Entra al proyecto:

```bash
cd gdev-tv-mode
```

Da permisos:

```bash
chmod +x install.sh
```

Instala:

```bash
./install.sh
```

Verifica:

```bash
gdev-tv --help
```

---

# 🩺 Diagnóstico

Antes de iniciar, verifica que todo el sistema esté listo.

```bash
gdev-tv doctor
```

El diagnóstico revisa:

- Kernel Linux
- VKMS
- xrandr
- Sunshine
- PulseAudio/PipeWire
- GPU Intel
- GPU AMD
- GPU Nvidia
- Firewall
- Permisos

---

# ▶️ Iniciar TV Mode

```bash
gdev-tv start
```

Este comando realiza automáticamente:

- Carga VKMS
- Espera la aparición del monitor virtual
- Configura resolución
- Configura escalado
- Configura DPI
- Configura Sunshine
- Redirecciona el audio
- Abre los puertos necesarios
- Inicia Sunshine

Todo en un solo comando.

---

# 📺 Conectarse desde Moonlight

Una vez iniciado:

1. Abre Moonlight.
2. Detecta Sunshine.
3. Selecciona Desktop.
4. Comienza a transmitir.

La TV mostrará únicamente la pantalla virtual.

La pantalla de la laptop permanece independiente.

---

# 📊 Estado

Consultar el estado actual:

```bash
gdev-tv status
```

Ejemplo:

```text
Virtual Display : ONLINE

Resolution      : 1280x720

Scale           : 1.0

Audio           : Virtual Sink

Firewall        : OPEN

Sunshine        : RUNNING
```

---

# ⏹️ Detener

Para regresar al modo Laptop:

```bash
gdev-tv stop
```

El proceso realiza:

- Cierra Sunshine
- Elimina el monitor virtual
- Cierra firewall
- Devuelve el audio a las bocinas
- Limpia recursos temporales

---

# 🔄 Reiniciar

```bash
gdev-tv restart
```

Equivale a:

```bash
gdev-tv stop
gdev-tv start
```

---

# ⚙️ Configuración

Toda la configuración se encuentra en:

```text
config/default.conf
```

Ejemplo:

```bash
########################################
# Pantalla
########################################

RESOLUTION="1280x720"

SCALE="1.0x1.0"

DPI="96"

########################################
# Audio
########################################

MANAGE_AUDIO=true

AUDIO_SINK_NAME="Gdev_Virtual_Audio"

########################################
# Sunshine
########################################

AUTO_START_SUNSHINE=true

########################################
# Firewall
########################################

MANAGE_FIREWALL=true
```

---

# 🎮 Flujo de funcionamiento

```text
Usuario

↓

gdev-tv start

↓

Doctor

↓

VKMS

↓

Monitor Virtual

↓

xrandr

↓

Audio Virtual

↓

Firewall

↓

Sunshine

↓

Moonlight

↓

TV
```

---

# 📁 Scripts

## display.sh

Diagnóstico del sistema.

Funciones:

- Detectar GPU
- Detectar X11
- Detectar Sunshine
- Detectar VKMS

---

## tv-mode.sh

Activa:

- VKMS
- xrandr
- Audio
- Sunshine
- Firewall

---

## laptop-mode.sh

Restaura:

- Audio
- Pantallas
- Firewall
- Sunshine

---

# 🔧 Makefile

Compilar validaciones:

```bash
make test
```

Instalar:

```bash
make install
```

Desinstalar:

```bash
make uninstall
```

---

# 📌 Comandos disponibles

```bash
gdev-tv doctor

gdev-tv start

gdev-tv stop

gdev-tv restart

gdev-tv status

gdev-tv --help
```

---

# 🛠️ Tecnologías

- Bash
- Linux
- VKMS
- xrandr
- PulseAudio
- PipeWire
- Sunshine
- Moonlight
- UFW

---

# 🧩 Compatibilidad

Probado en:

- Linux Mint 22.x
- Ubuntu 22.04
- Ubuntu 24.04

GPU compatibles:

- Intel
- AMD
- Nvidia

---

# 🚧 Roadmap

- [x] CLI unificada
- [x] Doctor
- [x] Audio automático
- [x] Firewall automático
- [x] Configuración externa
- [x] Instalador
- [ ] Wayland
- [ ] Multi-monitor
- [ ] HDR
- [ ] Perfil 4K
- [ ] Perfil 1080p
- [ ] Auto Update

---

# 🤝 Contribuir

Las contribuciones son bienvenidas.

Puedes colaborar con:

- Nuevas funciones
- Corrección de errores
- Documentación
- Compatibilidad con Wayland
- Optimización del código

Haz un Fork, crea una rama y abre un Pull Request.

---

# 📄 Licencia

Este proyecto se distribuye bajo la licencia MIT.

Puedes utilizarlo, modificarlo y distribuirlo libremente respetando los términos de dicha licencia.

---

# ❤️ Autor

Desarrollado por **GDEV**.

Creado para simplificar la transmisión de escritorios Linux mediante Sunshine + Moonlight con una configuración completamente automatizada.

---

# ☕ Agradecimientos

Gracias a los proyectos que hacen posible este trabajo:

- Linux
- VKMS
- xrandr
- PulseAudio
- PipeWire
- Sunshine
- Moonlight
- La comunidad Open Source

---

> **GDEV TV Mode** — Convierte tu laptop Linux en una estación de streaming profesional con un solo comando.
````
