#!/bin/sh

start_point() {
	while [ true ]; do
		cmd="`head -1 $PREFIX/$FIFO_NAME`"

		if [ -z "$cmd" ]; then
			continue
		fi

		if [ -x "$PREFIX/out/$cmd.sh" ]; then
			sh "$PREFIX/out/$cmd.sh"
		fi
	done
}
