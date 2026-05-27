# Supply Chain Demo Repo

This repository is a benign lab for demonstrating supply-chain risk in a repo
you control. It is intentionally local-only: the demo does not make outbound
network requests, install persistence, delete files, or read credential files.

## Demo 1: package lifecycle execution

On a second machine, clone the repo and run:

```sh
DEMO_SUPPLY_CHAIN_TOKEN=not-a-real-secret npm install
```

The `postinstall` lifecycle script runs automatically and writes evidence to:

```text
.obt-canary/postinstall-impact.json
```

That file shows what code execution during install can observe, including the
presence and length of the fake `DEMO_SUPPLY_CHAIN_TOKEN`. It does not record
the token value.

## Demo 2: agentic coding tool instructions

This repo also includes a `CLAUDE.md` project instruction canary. When Claude
Code loads the repository and follows project instructions, it should run:

```sh
npm run demo:agent-canary
```

That writes:

```text
.obt-canary/agent-tool-impact.json
```

This demonstrates that repository-controlled instructions can influence an
agentic coding tool's behavior. The canary script only writes local evidence.

## Reset

Remove generated demo evidence with:

```sh
npm run demo:clean
```
