const { exec } = require('child_process');
const net = require('net');
const http = require('http');
const WebSocket = require('ws');
const Gun = require('gun');
const path = require('path');
const os = require('os');
const fs = require('fs');

const gunHostDir = path.join(os.homedir(), '.gunhost');

describe('GunHost Service', () => {
  beforeAll(() => {
    if (!fs.existsSync(gunHostDir)) {
      fs.mkdirSync(gunHostDir);
    }
  });

  afterAll(() => {
    if (fs.existsSync(gunHostDir)) {
      fs.rmdirSync(gunHostDir, { recursive: true });
    }
  });

  test('should start and stop HTTP server', (done) => {
    exec('node src/gunhost.js start', (err, stdout, stderr) => {
      if (err) {
        done(err);
        return;
      }
      exec('lsof -i :8765', (err, stdout, stderr) => {
        expect(stdout).toContain('LISTEN');
        exec('node src/gunhost.js stop', (err, stdout, stderr) => {
          if (err) {
            done(err);
            return;
          }
          exec('lsof -i :8765', (err, stdout, stderr) => {
            expect(stdout).not.toContain('LISTEN');
            done();
          });
        });
      });
    });
  });

  test('should start and stop WebSocket server', (done) => {
    exec('node src/gunhost.js start', (err, stdout, stderr) => {
      if (err) {
        done(err);
        return;
      }
      exec('lsof -i :8766', (err, stdout, stderr) => {
        expect(stdout).toContain('LISTEN');
        exec('node src/gunhost.js stop', (err, stdout, stderr) => {
          if (err) {
            done(err);
            return;
          }
          exec('lsof -i :8766', (err, stdout, stderr) => {
            expect(stdout).not.toContain('LISTEN');
            done();
          });
        });
      });
    });
  });

  test('should start and stop local socket server', (done) => {
    exec('node src/gunhost.js start', (err, stdout, stderr) => {
      if (err) {
        done(err);
        return;
      }
      exec(`lsof ${path.join(gunHostDir, 'gun.sock')}`, (err, stdout, stderr) => {
        expect(stdout).toContain('LISTEN');
        exec('node src/gunhost.js stop', (err, stdout, stderr) => {
          if (err) {
            done(err);
            return;
          }
          exec(`lsof ${path.join(gunHostDir, 'gun.sock')}`, (err, stdout, stderr) => {
            expect(stdout).not.toContain('LISTEN');
            done();
          });
        });
      });
    });
  });

  test('should return status of servers', (done) => {
    exec('node src/gunhost.js start', (err, stdout, stderr) => {
      if (err) {
        done(err);
        return;
      }
      exec('node src/gunhost.js status', (err, stdout, stderr) => {
        expect(stdout).toContain('HTTP server is running');
        expect(stdout).toContain('WebSocket server is running');
        expect(stdout).toContain('Local socket server is running');
        exec('node src/gunhost.js stop', (err, stdout, stderr) => {
          done();
        });
      });
    });
  });
});
