#!/bin/bash
set -e
# when installing mecab-python3 with `pip install mecab-python3 [...] --platform win_amd64 --target .`, a dll will get lost.
# it can be avoided by omitting `--target` option, though we need Windows runner to do that.
# therefore i'm manually copying the dll, since we are running on linux runners.

PATH_VENDOR=$(realpath "$1")
PATH_OUT="$PATH_VENDOR/MeCab"
if [ ! -d "$PATH_OUT" ]; then
    echo "[FIX] skip when Mecab folder does not exist"
    exit 0
fi
DLL="libmecab.dll"

DEP=$(pip freeze | grep -P "mecab-python3")
WHEEL=$(pip download --only-binary=:all: --no-deps --platform win_amd64 $DEP | grep -oP "(?<=Saved ).*" | tr '\\' '/')
if [ -z "$WHEEL" ]; then
    echo "[FIX] failed to download mecab-python3 wheel"
    exit 1
fi
trap 'rm -f $WHEEL' EXIT

python <<EOF
import zipfile
import os

# go through the wheel and find the dll, then copy it to the output folder
with zipfile.ZipFile("$WHEEL", "r") as z:
    for f in z.namelist():
        if f.endswith("$DLL"):
            with z.open(f) as zf:
                with open("$DLL", "wb") as out:
                    out.write(zf.read())
            exit(0)

print("failed to find $DLL in the wheel")
exit(1)
EOF

mv -f "$DLL" "$PATH_OUT"
echo "[FIX] done"
