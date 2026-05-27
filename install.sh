#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

sh "$ROOT/scripts/install-canary.sh"
