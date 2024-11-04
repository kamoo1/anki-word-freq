#!/bin/bash
echoerr() { echo "$@" 1>&2; }
set -e
TOP_DEPS="$@"
DEPS=""
for dep in $TOP_DEPS; do
    DEPS=$DEPS$(poetry show -t $dep | grep -oP "(?<= )[\w\-_]+(?= [\>\<\=\*])")$'\n'
done
# add top deps to the list
DEPS=$DEPS$(echo "$TOP_DEPS" | tr ' ' '\n')
DEPS=$(echo "$DEPS" | sort | uniq | grep "\S")
REGEX=$(python <<EOF
import sys
lines = """$DEPS""".split("\n")
lines = [f"^{line}==" for line in lines]
regex = "|".join(lines)
print(regex)
EOF
)
DEPS=$(pip freeze | grep -P "$REGEX")
echo "$DEPS"