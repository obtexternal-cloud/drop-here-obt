#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
rm -rf -- "$ROOT/.obt-canary"
printf '%s\n' '[obt-canary] removed .obt-canary evidence directory.'
