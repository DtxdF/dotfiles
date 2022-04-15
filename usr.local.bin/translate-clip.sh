#!/bin/sh

TEMPFILE=`mktemp -t clip2translate` || exit 1

trap "rm -f ${TEMPFILE}" EXIT

CLIPBOARD="`xclip -out -selection clipboard`"

translate -fen -tes "${CLIPBOARD}" > ${TEMPFILE}

xterm -e less ${TEMPFILE}
