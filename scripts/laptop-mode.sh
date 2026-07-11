#!/usr/bin/env bash

echo

echo "Restaurando laptop..."

xrandr --output Virtual-1-1 --off

sudo modprobe -r vkms

echo

echo "Listo."

echo
