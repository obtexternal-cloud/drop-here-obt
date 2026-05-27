const fs = require('fs');
const path = require('path');

const root = process.env.CLAUDE_PROJECT_DIR
  ? path.resolve(process.env.CLAUDE_PROJECT_DIR)
  : path.resolve(__dirname, '..');
const outputDir = path.join(root, '.obt-canary');
const surface = (process.argv[2] || 'unknown-surface').replace(/[^a-z0-9._-]/gi, '-');
const markerPath = path.join(outputDir, `${surface}-impact.json`);
const logPath = path.join(outputDir, 'claude-surfaces.ndjson');

let stdin = '';
let finalized = false;

fs.mkdirSync(outputDir, { recursive: true });

function finalize() {
  if (finalized) return;
  finalized = true;

  let parsedInput = null;
  try {
    parsedInput = stdin.trim() ? JSON.parse(stdin) : null;
  } catch {
    parsedInput = { parseError: true, byteLength: Buffer.byteLength(stdin) };
  }

  const report = {
    scenario: 'Claude Code extension surface executed a local canary',
    surface,
    timestamp: new Date().toISOString(),
    workingDirectory: process.cwd(),
    claudeEnvironment: {
      projectDirPresent: Boolean(process.env.CLAUDE_PROJECT_DIR),
      skillDirPresent: Boolean(process.env.CLAUDE_SKILL_DIR),
      pluginRootPresent: Boolean(process.env.CLAUDE_PLUGIN_ROOT)
    },
    hookInputSummary: parsedInput
      ? {
          keys: Object.keys(parsedInput),
          hookEventName: parsedInput.hook_event_name || parsedInput.hookEventName || null,
          toolName: parsedInput.tool_name || null
        }
      : null,
    impact: 'local marker file created inside the repository',
    localOnly: true,
    networkRequests: 0,
    secretFileReads: 0,
    destructiveActions: 0,
    persistenceInstalled: false
  };

  fs.writeFileSync(markerPath, `${JSON.stringify(report, null, 2)}\n`);
  fs.appendFileSync(logPath, `${JSON.stringify(report)}\n`);

  console.log(`[obt-canary] Claude surface canary executed: ${surface}`);
  console.log(`[obt-canary] wrote local evidence to ${path.relative(root, markerPath)}`);
}

if (process.stdin.isTTY) {
  finalize();
} else {
  process.stdin.setEncoding('utf8');
  process.stdin.on('data', chunk => {
    stdin += chunk;
  });
  process.stdin.on('end', finalize);
  setTimeout(finalize, 250);
}
