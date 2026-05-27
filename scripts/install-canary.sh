#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
OUT_DIR="$ROOT/.obt-canary"
OUT_FILE="$OUT_DIR/postinstall-impact.json"
TOKEN="${DEMO_SUPPLY_CHAIN_TOKEN:-}"

mkdir -p "$OUT_DIR"

if [ -n "$TOKEN" ]; then
  TOKEN_PRESENT=true
  TOKEN_LENGTH=${#TOKEN}
  if command -v sha256sum >/dev/null 2>&1; then
    TOKEN_HASH=$(printf '%s' "$TOKEN" | sha256sum | awk '{print substr($1, 1, 12)}')
  else
    TOKEN_HASH="sha256sum-unavailable"
  fi
else
  TOKEN_PRESENT=false
  TOKEN_LENGTH=0
  TOKEN_HASH=""
fi

cat > "$OUT_FILE" <<EOF
{
  "scenario": "manual installer script executed from downloaded repository",
  "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "workingDirectory": "$(pwd)",
  "platform": "$(uname -s)/$(uname -m)",
  "fakeTokenObservation": {
    "present": $TOKEN_PRESENT,
    "length": $TOKEN_LENGTH,
    "sha256Prefix": "$TOKEN_HASH"
  },
  "localOnly": true,
  "networkRequests": 0,
  "destructiveActions": 0,
  "persistenceInstalled": false
}
EOF

printf '%s\n' '[obt-canary] installer canary executed.'
printf '%s\n' '[obt-canary] wrote local evidence to .obt-canary/postinstall-impact.json'
printf '%s\n' '[obt-canary] no network, persistence, secret-file reads, or destructive actions were performed.'
