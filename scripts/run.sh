#!/usr/bin/env bash
set -euo pipefail

usage() {
    echo "Usage: $0 [debug|release]"
}

PRESET="${1:-debug}"

if [[ $# -gt 1 || ( "$PRESET" != "debug" && "$PRESET" != "release" ) ]]; then
    usage
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "$REPO_ROOT"

PROJECT_NAME="$(
    awk '
        /^[[:space:]]*project[[:space:]]*\(/ {
            line = $0
            sub(/^[[:space:]]*project[[:space:]]*\([[:space:]]*/, "", line)
            sub(/[[:space:]\)].*$/, "", line)
            gsub(/"/, "", line)
            if (line != "") {
                print line
                exit
            }
        }
    ' CMakeLists.txt
)"

if [[ -z "$PROJECT_NAME" ]]; then
    echo "Error: could not read project name from CMakeLists.txt."
    exit 1
fi

EXECUTABLE="build/${PRESET}/bin/${PROJECT_NAME}"

echo "Configuring preset: ${PRESET}"
cmake --preset "$PRESET"

echo "Building preset: ${PRESET}"
cmake --build --preset "$PRESET"

if [[ ! -x "$EXECUTABLE" ]]; then
    echo "Error: executable not found or not executable: ${EXECUTABLE}"
    exit 1
fi

if [[ -t 1 ]] && command -v clear >/dev/null 2>&1; then
    clear
fi

if [[ -t 1 ]]; then
    printf '\033[32m========== Build Finished. Running %s ==========\033[0m\n\n\n' "$PROJECT_NAME"
else
    printf '========== Build Finished. Running %s ==========\n\n\n' "$PROJECT_NAME"
fi

set +e
"./${EXECUTABLE}"
RUN_EXIT_CODE=$?
set -e

if [[ -t 1 ]]; then
    printf '\n\n\033[32m========== Run Finished. Exiting. ==========\033[0m\n'
else
    printf '\n\n========== Run Finished. Exiting. ==========\n'
fi

exit "$RUN_EXIT_CODE"
