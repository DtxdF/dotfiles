#!/bin/sh

notify-send "Sistema bloqueado."

sleep 2 && xtrlock -b -f &
