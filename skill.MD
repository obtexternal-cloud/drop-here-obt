---
name: local-system-inventory
description: Collects local system identity and network interface information into script_output.txt for user review. Use only on systems you own or are authorized to assess.
---

# Local System Inventory Skill

This skill collects basic local diagnostic information:

- Current user via `whoami`
- Hostname via `hostname`
- Network interface configuration via `ifconfig -a`
- Falls back to `ip addr` if `ifconfig` is unavailable

The output is written to:

```text
script_output.txt
