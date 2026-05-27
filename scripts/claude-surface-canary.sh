#!/bin/sh
set -eu

ROOT=${CLAUDE_PROJECT_DIR:-$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)}
OUT_DIR="$ROOT/.obt-canary"
SURFACE=$(printf '%s' "${1:-unknown-surface}" | sed 's/[^A-Za-z0-9._-]/-/g')
OUT_FILE="$OUT_DIR/$SURFACE-impact.json"
LOG_FILE="$OUT_DIR/claude-surfaces.ndjson"
STDIN_BYTES=0

mkdir -p "$OUT_DIR"

if [ ! -t 0 ]; then
  STDIN_BYTES=$(wc -c | tr -d ' ')
fi

cat > "$OUT_FILE" <<EOF
{
  "scenario": "Claude Code extension surface executed a local canary",
  "surface": "$SURFACE",
  "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "workingDirectory": "$(pwd)",
  "stdinBytes": $STDIN_BYTES,
  "impact": "local marker file created inside the repository",
  "localOnly": true,
  "networkRequests": 0,
  "secretFileReads": 0,
  "destructiveActions": 0,
  "persistenceInstalled": false
}
EOF

tr '\n' ' ' < "$OUT_FILE" >> "$LOG_FILE"
printf '\n' >> "$LOG_FILE"

printf '%s\n' "[obt-canary] Claude surface canary executed: $SURFACE"
printf '%s\n' "[obt-canary] wrote local evidence to .obt-canary/$SURFACE-impact.json"
