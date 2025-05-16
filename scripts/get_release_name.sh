#!/bin/bash
# TAG get passed down from github actions as the next version we should release
# If TAG is not set, we will use the current version from poetry
if [ -z "$TAG" ]; then
    TAG=v$(python -m semantic_release version --print)
fi
read -r PROJECT_NAME _ <<< "$(poetry version)"
PYTHON_VERSION=$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
FILENAME="${PROJECT_NAME}_${TAG}_py${PYTHON_VERSION}"
echo "$FILENAME"
