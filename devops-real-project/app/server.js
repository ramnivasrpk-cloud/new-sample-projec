'use strict';

const http = require('node:http');

const port = Number(process.env.PORT || 3000);
const serviceName = process.env.SERVICE_NAME || 'devops-demo';

const server = http.createServer((req, res) => {
  if (req.url === '/health' || req.url === '/ready') {
    res.writeHead(200, { 'content-type': 'application/json' });
    return res.end(JSON.stringify({ status: 'ok', service: serviceName }));
  }

  if (req.url === '/version') {
    res.writeHead(200, { 'content-type': 'application/json' });
    return res.end(JSON.stringify({ version: process.env.APP_VERSION || '1.0.0' }));
  }

  res.writeHead(200, { 'content-type': 'application/json' });
  res.end(JSON.stringify({
    message: 'Hello from a containerized service',
    service: serviceName,
    path: req.url
  }));
});

server.listen(port, '0.0.0.0', () => {
  console.log(`${serviceName} listening on port ${port}`);
});

function shutdown(signal) {
  console.log(`${signal} received; shutting down gracefully`);
  server.close(() => process.exit(0));
  setTimeout(() => process.exit(1), 10000).unref();
}
process.on('SIGTERM', () => shutdown('SIGTERM'));
process.on('SIGINT', () => shutdown('SIGINT'));
