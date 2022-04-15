#!/bin/sh

set -e

# Default value if the .brightness/xbrightness file doesn't exists
BRIGHTNESS=.90
BRIGHTNESS_FILE=~/.brightness/brightness

if [ -f "${BRIGHTNESS_FILE}" ]; then
	BRIGHTNESS=`cat ${BRIGHTNESS_FILE}`
fi

# Set brigtness
xrandr-brightness.sh ${BRIGHTNESS} &

# Set the wallpaper
~/.fehbg &

# Run pywal
wal -R -steqnl &

# Set the configurations for X's apps
xrdb -load .Xresources &

# Set the keyboard-layout
setxkbmap es &

# Run the compositor
picom &

# D-BUS will cry
set +e

# Fire!
exec dbus-launch --exit-with-x11 cwm
