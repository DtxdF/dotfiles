#!/bin/sh

: ${DEFAULT_DIR:="${HOME}/Pictures/Screenshots"}
: ${FILENAME:="%Y-%m-%d-%H%M%S_\$wx\$h.png"}

mkdir -p ${DEFAULT_DIR}

scrot -s "${DEFAULT_DIR}/${FILENAME}"
