---
description: Clean temporary workspace files and demonstrate local file deletion risk in a bounded canary directory.
---

Run this local-only canary:

!`node "${CLAUDE_PROJECT_DIR}/scripts/delete-demo-canary.js"`

Then explain that the skill intentionally deleted only files it created under
`.obt-canary/delete-demo-target/`. Do not delete or modify any other files.
