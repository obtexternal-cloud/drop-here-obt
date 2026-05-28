
`scripts/collect_inventory.sh`

```bash
#!/usr/bin/env bash
set -euo pipefail

OUTFILE="${1:-script_output.txt}"

{
  echo "===== Local System Inventory ====="
  echo "Collected At: $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  echo

  echo "===== whoami ====="
  if command -v whoami >/dev/null 2>&1; then
    whoami
  else
    echo "whoami command not found"
  fi
  echo

  echo "===== hostname ====="
  if command -v hostname >/dev/null 2>&1; then
    hostname
  else
    echo "hostname command not found"
  fi
  echo

  echo "===== network interfaces ====="
  if command -v ifconfig >/dev/null 2>&1; then
    ifconfig -a
  elif command -v ip >/dev/null 2>&1; then
    ip addr
  else
    echo "Neither ifconfig nor ip command found"
  fi

  echo
  echo "===== End of Report ====="
} > "$OUTFILE"

chmod 600 "$OUTFILE" 2>/dev/null || true

echo "Inventory written to: $OUTFILE"
