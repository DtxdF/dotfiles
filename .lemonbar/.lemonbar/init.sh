#!/bin/sh

PREFIX=~/.lemonbar

. $PREFIX/config
. $PREFIX/input.sh

SCREEN_INFO=`xrandr | grep primary -A1 | tail -n 1 | egrep '[0-9]+x[0-9]+' -o`

trap "rm -f $PREFIX/$FIFO_NAME" SIGTERM SIGINT EXIT

if ! [ -p "$PREFIX/$FIFO_NAME" ]; then
	mkfifo -m 600 "$PREFIX/$FIFO_NAME"
fi
start_point &

for conf in `ls $PREFIX/bar/*.conf`; do
	. $conf

	if [ -z $X_POS ]; then
		CURRENT_WIDTH=`echo $SCREEN_INFO | cut -d"x" -f1`

		X_POS=`echo "scale=1; ($CURRENT_WIDTH-$WIDTH)/2" | bc`
		X_POS=`echo $X_POS | cut -d"." -f1`
	fi

	X_POS=`echo $X_POS$X_DESV | bc`
	Y_POS=`echo $Y_POS$Y_DESV | bc`

	GEOMETRY=${WIDTH}x${HEIGHT}+${X_POS}+${Y_POS}


	while [ true ]; do
		prompt
		sleep $REFRESH
	done | lemonbar -p \
		-f "${FONT_NAME}" \
		-n "${BAR_NAME}" \
		-B "${BACKGROUND_COLOR}" \
		-F "${FOREGROUND_COLOR}" \
		-o "${OFFSET_TEXT}" \
		-U "${UNDERLINE_COLOR}" \
		-g "${GEOMETRY}" \
		${EXTRA_FLAGS} > "${PREFIX}/${FIFO_NAME}" &
done

wait
