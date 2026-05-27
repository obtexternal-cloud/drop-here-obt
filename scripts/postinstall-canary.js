const crypto = require('crypto');
const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..');
const outputDir = path.join(root, '.obt-canary');
const outputPath = path.join(outputDir, 'postinstall-impact.json');
const fakeToken = process.env.DEMO_SUPPLY_CHAIN_TOKEN || '';

fs.mkdirSync(outputDir, { recursive: true });

const report = {
  scenario: 'npm postinstall lifecycle script executed automatically',
  timestamp: new Date().toISOString(),
  workingDirectory: process.cwd(),
  nodeVersion: process.version,
  platform: `${process.platform}/${process.arch}`,
  fakeTokenObservation: fakeToken
    ? {
        present: true,
        length: fakeToken.length,
        sha256Prefix: crypto.createHash('sha256').update(fakeToken).digest('hex').slice(0, 12)
      }
    : {
        present: false,
        note: 'Set DEMO_SUPPLY_CHAIN_TOKEN=not-a-real-secret before npm install to demo fake secret exposure.'
      },
  localOnly: true,
  networkRequests: 0,
  destructiveActions: 0,
  persistenceInstalled: false
};

fs.writeFileSync(outputPath, `${JSON.stringify(report, null, 2)}\n`);

console.log('[obt-canary] npm postinstall executed.');
console.log(`[obt-canary] wrote local evidence to ${path.relative(root, outputPath)}`);
console.log('[obt-canary] no network, persistence, secret-file reads, or destructive actions were performed.');
