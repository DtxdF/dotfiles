#!/bin/sh

set -e

# see sysexits(3)
EX_USAGE=64

: ${BRIGHTNESS_CONFIG:=${HOME}/.brightness}
: ${BRIGHTNESS:=${BRIGHTNESS_CONFIG}/brightness}

get_current_brightness()
{
	CURRENT_BRIGHTNESS=`xrandr --verbose | grep primary -A5 | grep Brightness | cut -d":" -f2 | tr -d ""`

	echo -n ${CURRENT_BRIGHTNESS}
}

if [ $# -ne 1 ]; then
	echo "usage: `basename $0` OPERATION"
	exit $EX_USAGE
fi

BRIGHTNESS_OP=$1

# Initial current brightness
CURRENT_BRIGHTNESS=`get_current_brightness`

if [ "$BRIGHTNESS_OP" = "+" ]; then
	BRIGHTNESS_VALUE=`echo ${CURRENT_BRIGHTNESS}+0.1 | bc`
elif [ "$BRIGHTNESS_OP" = "-" ]; then
	BRIGHTNESS_VALUE=`echo ${CURRENT_BRIGHTNESS}-0.1 | bc`
else
	# Use the BRIGHTNESS_VALUE value instead of sum him or subtract him
	BRIGHTNESS_VALUE=${BRIGHTNESS_OP}
fi

# PRIMARY SCREEN
OUTPUT=`xrandr | grep primary | cut -d" " -f1`

xrandr --output "$OUTPUT" --brightness ${BRIGHTNESS_VALUE}

# For .xinitrc
mkdir -p "`dirname ${BRIGHTNESS}`"

echo -n "${BRIGHTNESS_VALUE}" > "${BRIGHTNESS}"
