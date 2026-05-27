const fs = require('fs');
const path = require('path');

const outputDir = path.resolve(__dirname, '..', '.obt-canary');

fs.rmSync(outputDir, { recursive: true, force: true });
console.log('[obt-canary] removed .obt-canary evidence directory.');
