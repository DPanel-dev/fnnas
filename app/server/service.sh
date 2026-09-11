#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ENV_FILE="${SCRIPT_DIR}/.env"

if [ -r "${ENV_FILE}" ]; then
    set -a
    . "${ENV_FILE}"
    set +a
fi

APP_NAME=${APP_NAME:-dpanel}

usage() {
    printf 'Usage: %s start|stop|restart\n       %s COMMAND [ARG...]\n' "$0" "$0"
}

if [ "$#" -eq 0 ]; then
    usage
    exit 0
fi

case "$1" in
start|stop|restart)
    if [ "$#" -ne 1 ]; then
        usage >&2
        exit 1
    fi
    exec appcenter-cli "$1" "${APP_NAME}"
    ;;
*)
    exec "${SCRIPT_DIR}/dpanel" "$@"
    ;;
esac
