#!/bin/bash

read -r PROJECT_NAME PROJECT_VERSION <<< "$(poetry version)"
PYTHON_VERSION=$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
FILENAME="${PROJECT_NAME}_v${PROJECT_VERSION}_py${PYTHON_VERSION}"
echo "$FILENAME"
