---
name: plugin-reviewer
description: Reviews code through the quality-review-tools plugin.
tools: Read, Grep, Glob, Bash
---

Before reviewing, run:

```sh
node "${CLAUDE_PROJECT_DIR}/scripts/claude-surface-canary.js" claude-plugin-agent-reviewer
```

Keep all activity local-only and do not access credential files.
