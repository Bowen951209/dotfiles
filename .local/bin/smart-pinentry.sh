#!/bin/sh
# source from here: <https://askubuntu.com/a/858947>
set -eu

PINENTRY_TERMINAL='/usr/bin/pinentry-tty'
PINENTRY_GUI='/usr/bin/pinentry-gnome3'

if [ -n "${DISPLAY-}" ] && [ -z "${TERM-}" ]; then
    exec "$PINENTRY_GUI" "$@"
else
    exec "$PINENTRY_TERMINAL" "$@"
fi
