#!/usr/bin/env bash
# scripts/streaming-control.sh

APP_TARGET=$(echo "$1" | tr '[:upper:]' '[:lower:]')
SEARCH_QUERY=$2
TV_IP="192.168.1.7"

# Asegurar conexión ADB
adb connect "$TV_IP:5555" > /dev/null 2>&1

case "$APP_TARGET" in
    netflix)
        echo "[STREAMING] Lanzando Netflix..."
        adb shell am start -n com.netflix.ninja/.MainActivity > /dev/null 2>&1
        ;;
    disney|disney+)
        echo "[STREAMING] Lanzando Disney+..."
        adb shell am start -n com.disney.disneyplus/com.bamtechmedia.dominguez.main.MainActivity > /dev/null 2>&1
        ;;
    amazon|prime)
        echo "[STREAMING] Lanzando Amazon Prime Video..."
        adb shell am start -n com.amazon.amazonvideo.livingroom/com.amazon.ignition.IgnitionActivity > /dev/null 2>&1
        ;;
    *)
        echo "[WARN] Aplicación no reconocida. Abriendo búsqueda global..."
        ;;
esac

# Si el usuario mandó texto para buscar, se inyecta tras esperar a que abra la app
if [[ -n "$SEARCH_QUERY" ]]; then
    echo "[STREAMING] Buscando el título: $SEARCH_QUERY..."
    sleep 5 # Tiempo de cortesía para que la app cargue el foco
    # Simula presionar el botón de búsqueda nativo si la app tiene soporte global o usa el buscador de Android
    adb shell am start -a "android.search.action.GLOBAL_SEARCH" --es query "$SEARCH_QUERY" > /dev/null 2>&1
fi
