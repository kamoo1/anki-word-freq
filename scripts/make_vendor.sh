#!/bin/bash
set -e
PATH_OUT=$(realpath "$1")
mkdir -p "$PATH_OUT"
PACKAGE="$2"
PLATFORMS="${@:3}"
PYTHON_VERSION=python3.9
TEMPP=$(mktemp -d)
if [ ! -d "$TEMPP" ]; then
    echo "[Vendor] Failed to create temp dir"
    exit 1
fi
IMPORT_NAMES=""
PIP_INSTALL="pip install --upgrade --no-deps --target $TEMPP --platform %s "
trap 'rm -rf -- "$TEMPP"' EXIT

function warn() {
    echo -e "\033[0;31m$1\033[0m"
}

for PLATFORM in $PLATFORMS; do
    echo "[Vendor] Installing $PACKAGE ($PLATFORM) to temp dir"
    CMD=$(printf "$PIP_INSTALL" "$PLATFORM")
    eval "$CMD" "$PACKAGE" 1>/dev/null || continue
    rm -rf -- $TEMPP/*.dist-info
    echo "[Vendor] Copying $PACKAGE ($PLATFORM) to vendor"
    tar c -C "$TEMPP" . | tar xf - -C "$PATH_OUT"
    rm -rf -- $TEMPP/*
done

