#!/bin/bash
set -e
PATH_OUT=$(realpath "$1")
mkdir -p "$PATH_OUT"
PACKAGE="$2"
PLATFORMS="${@:3}"
PYTHON_VERSION=python3.9
TEMPP=$(mktemp -d)
IMPORT_NAMES=""
PIP_INSTALL="pip install --upgrade --only-binary=:all: --no-deps --target $TEMPP --platform %s "
trap 'echo [Vendor] removing "$TEMPP" && rm -rf -- "$TEMPP"' EXIT

echo ""
echo ""
echo ""

function get_import_names() {
    local DEP=$1
    johnnydep --output-format json --fields import_names --verbose 0 $DEP | jq -r '.[0].import_names[]'
}

PATH_SITE=$(python <<EOF
import sys
for path in sys.path:
    if path.endswith("site-packages"):
        print(path)
        break
EOF
)
if [ -z "$PATH_SITE" ]; then
    echo "[Vendor] site-packages path not found"
    exit 1
fi
for PLATFORM in $PLATFORMS; do
    if [ -z "$IMPORT_NAMES" ]; then
        IMPORT_NAMES=$(get_import_names $PACKAGE)
        # copy existing folder to the output (not all wheels will be installed, because the --only-binary flag)
        echo "[Vendor] Copying existing $PACKAGE to vendor from site-packages"
        xargs -I{} cp -r $PATH_SITE/{} $PATH_OUT/ <<< "$IMPORT_NAMES"
    fi
    echo "[Vendor] Downloading $PACKAGE ($PLATFORM)"
    CMD=$(printf "$PIP_INSTALL" "$PLATFORM")
    # if download fails, it means package is universal, we can skip it
    # since we copied from site-packages already
    eval "$CMD" "$PACKAGE"
    echo "[Vendor] Copying $PACKAGE ($PLATFORM) to vendor"
    tar c -C "$TEMPP" "$IMPORT_NAMES" | tar xf - -C "$PATH_OUT"

done

echo "[Vendor] Done"

