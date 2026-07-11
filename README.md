# 📺 GDEV TV Mode

> Convierte un monitor virtual de Linux en una segunda pantalla física utilizando **VKMS + Sunshine + Moonlight**, automatizando toda la configuración con un solo comando.

---

# 🚀 Objetivo

GDEV TV Mode nace para resolver un problema muy común en Linux:

- Compartir pantalla únicamente duplica el escritorio.
- No existe un monitor HDMI conectado.
- Se desea utilizar una TV como un segundo monitor real.
- Sunshine ya soporta múltiples displays, pero configurarlo manualmente es tedioso.

Este proyecto automatiza todo el proceso.

---

# ✨ Características

- ✔ Creación automática de monitor virtual (VKMS)
- ✔ Configuración automática mediante xrandr
- ✔ Integración con Sunshine
- ✔ Compatible con Moonlight
- ✔ Restauración del escritorio
- ✔ Detección automática del entorno
- ✔ Logs
- ✔ Configuración mediante archivo
- ✔ Arquitectura modular

---

# 📦 Requisitos

Actualmente probado con:

| Software | Versión |
|----------|----------|
| Linux Mint | 22.3 |
| Cinnamon | X11 |
| Sunshine | Flatpak |
| Moonlight | Android TV |
| Kernel | 6.x |
| VKMS | habilitado |

---

# 📂 Arquitectura

```
gdev-tv-mode/

├── bin/
│   └── gdev-tv
│
├── config/
│   └── default.conf
│
├── lib/
│   ├── audio.sh
│   ├── checks.sh
│   ├── colors.sh
│   ├── config.sh
│   ├── display.sh
│   ├── helpers.sh
│   ├── logger.sh
│   ├── sunshine.sh
│   ├── system.sh
│   └── vkms.sh
│
├── logs/
│
├── README.md
├── install.sh
└── uninstall.sh
```

---

# 🚀 Instalación

```bash
git clone https://github.com/<usuario>/gdev-tv-mode.git

cd gdev-tv-mode

chmod +x install.sh

./install.sh
```

---

# Uso

## Activar modo TV

```bash
gdev-tv start
```

---

## Restaurar modo Laptop

```bash
gdev-tv stop
```

---

## Estado

```bash
gdev-tv status
```

---

## Diagnóstico

```bash
gdev-tv doctor
```

---

## Reiniciar

```bash
gdev-tv restart
```

---

# Flujo

```
Usuario

↓

gdev-tv start

↓

Verificaciones

↓

VKMS

↓

Virtual Display

↓

xrandr

↓

Sunshine

↓

Moonlight

↓

Segundo Monitor listo
```

---

# Configuración

Toda la configuración vive en

```
config/default.conf
```

Ejemplo:

```ini
MONITOR=eDP-1

VIRTUAL=Virtual-1-1

WIDTH=1920

HEIGHT=1080

POSITION=right

AUTO_START_SUNSHINE=true

AUTO_LOAD_VKMS=true
```

---

# Roadmap

## v1

- [x] Monitor Virtual
- [x] Sunshine
- [x] Moonlight
- [ ] Script principal
- [ ] Instalador

## v2

- [ ] Audio automático
- [ ] Detección de DPI
- [ ] Estado en tiempo real
- [ ] Doctor

## v3

- [ ] GUI
- [ ] Multi Monitor
- [ ] Wayland
- [ ] Fedora
- [ ] Ubuntu

---

# Filosofía

> Automatizar tareas repetitivas para que el desarrollador sólo tenga que escribir:

```bash
gdev-tv start
```

y comenzar a trabajar.

---

# Licencia

MIT License

---

Creado con ☕, Bash y muchas horas de debugging.
