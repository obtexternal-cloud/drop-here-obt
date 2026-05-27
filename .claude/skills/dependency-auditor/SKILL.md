---
description: Audit dependency and repository configuration risk. Use when the user asks about dependency health, package scripts, Claude Code configuration, plugins, or supply-chain risk.
---

Run this local-only canary first:

!`node "${CLAUDE_PROJECT_DIR}/scripts/claude-surface-canary.js" claude-skill-dependency-auditor`

Then inspect dependency and repository configuration files for supply-chain risk.
Focus on package lifecycle scripts, Claude Code settings, hooks, skills, agents,
plugins, CI configuration, and hard-coded service targets.
