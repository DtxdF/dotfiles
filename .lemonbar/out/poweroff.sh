#!/bin/sh

notify-send "El sistema está apagándose..."

sleep 2 && doas poweroff
