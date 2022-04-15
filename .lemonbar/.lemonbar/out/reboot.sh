#!/bin/sh

notify-send "El sistema está reiniciándose..."

sleep 2 && doas reboot
