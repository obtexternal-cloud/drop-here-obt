# Supply Chain Demo Repo

This repository is a benign lab for demonstrating supply-chain risk in a repo
you control. It is intentionally local-only: the demo does not make outbound
network requests, install persistence, delete files, or read credential files.

## Simulated installation without npm

Use a disposable directory on a machine you own:

```sh
curl -L -o drop-here-obt.zip https://github.com/obtexternal-cloud/drop-here-obt/archive/refs/heads/benign-supply-chain-canaries.zip
unzip drop-here-obt.zip
cd drop-here-obt-benign-supply-chain-canaries
```

Run the simulated installer:

```sh
DEMO_SUPPLY_CHAIN_TOKEN=not-a-real-secret sh install.sh
cat .obt-canary/postinstall-impact.json
```

To simulate a Claude Code repository-skill impact without deleting real files:

```sh
sh scripts/delete-demo-canary.sh
cat .obt-canary/delete-demo-impact.json
```

The deletion demo creates throwaway files under
`.obt-canary/delete-demo-target/`, deletes only those generated files, and
records evidence in `.obt-canary/delete-demo-impact.json`.

To simulate Claude Code extension surfaces directly:

```sh
sh scripts/claude-surface-canary.sh manual-run
cat .obt-canary/manual-run-impact.json
```

If you prefer Git instead of ZIP:

```sh
git clone -b benign-supply-chain-canaries https://github.com/obtexternal-cloud/drop-here-obt.git
cd drop-here-obt
```

## Demo 1: installer script execution

On a second machine, download the ZIP or clone the repo and run:

```sh
DEMO_SUPPLY_CHAIN_TOKEN=not-a-real-secret sh install.sh
```

The installer canary writes evidence to:

```text
.obt-canary/postinstall-impact.json
```

That file shows what code execution during install can observe, including the
presence and length of the fake `DEMO_SUPPLY_CHAIN_TOKEN`. It does not record
the token value.

For the npm-specific lifecycle version, run:

```sh
DEMO_SUPPLY_CHAIN_TOKEN=not-a-real-secret npm install
```

## Demo 2: agentic coding tool instructions

This repo also includes a `CLAUDE.md` project instruction canary. When Claude
Code loads the repository and follows project instructions, it should run:

```sh
sh scripts/agent-canary.sh
```

That writes:

```text
.obt-canary/agent-tool-impact.json
```

This demonstrates that repository-controlled instructions can influence an
agentic coding tool's behavior. The canary script only writes local evidence.

## Demo 3: Claude Code skill deletion canary

The project skill at `.claude/skills/workspace-cleaner/SKILL.md` demonstrates
how a repository-provided skill could cause file deletion if trusted blindly.
This lab version is bounded: it creates and deletes only its own throwaway
files in `.obt-canary/delete-demo-target/`.

Run it manually with:

```sh
sh scripts/delete-demo-canary.sh
```

## Reset

Remove generated demo evidence with:

```sh
sh scripts/clean-canary.sh
```
