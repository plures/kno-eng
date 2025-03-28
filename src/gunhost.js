const http = require('http');
const WebSocket = require('ws');
const net = require('net');
const Gun = require('gun');
const fs = require('fs');
const path = require('path');
const os = require('os');
const { exec } = require('child_process');

const gun = Gun();

const gunHostDir = path.join(os.homedir(), '.gunhost');
if (!fs.existsSync(gunHostDir)) {
  fs.mkdirSync(gunHostDir);
}

const httpServer = http.createServer((req, res) => {
  gun.wsp.server(req, res);
});

const wsServer = new WebSocket.Server({ server: httpServer });
wsServer.on('connection', (socket) => {
  const stream = new Gun.stream(socket);
  gun.wsp.stream(stream);
});

const socketServer = net.createServer((socket) => {
  const stream = new Gun.stream(socket);
  gun.wsp.stream(stream);
});

const startServer = () => {
  httpServer.listen(8765, () => {
    console.log('HTTP server listening on port 8765');
  });

  wsServer.listen(8766, () => {
    console.log('WebSocket server listening on port 8766');
  });

  socketServer.listen(path.join(gunHostDir, 'gun.sock'), () => {
    console.log('Local socket server listening on', path.join(gunHostDir, 'gun.sock'));
  });
};

const stopServer = () => {
  httpServer.close(() => {
    console.log('HTTP server stopped');
  });

  wsServer.close(() => {
    console.log('WebSocket server stopped');
  });

  socketServer.close(() => {
    console.log('Local socket server stopped');
  });
};

const getStatus = () => {
  exec('lsof -i :8765', (err, stdout, stderr) => {
    if (stdout) {
      console.log('HTTP server is running');
    } else {
      console.log('HTTP server is not running');
    }
  });

  exec('lsof -i :8766', (err, stdout, stderr) => {
    if (stdout) {
      console.log('WebSocket server is running');
    } else {
      console.log('WebSocket server is not running');
    }
  });

  exec(`lsof ${path.join(gunHostDir, 'gun.sock')}`, (err, stdout, stderr) => {
    if (stdout) {
      console.log('Local socket server is running');
    } else {
      console.log('Local socket server is not running');
    }
  });
};

const args = process.argv.slice(2);
switch (args[0]) {
  case 'start':
    startServer();
    break;
  case 'stop':
    stopServer();
    break;
  case 'status':
    getStatus();
    break;
  default:
    console.log('Usage: node gunhost.js [start|stop|status]');
    break;
}
