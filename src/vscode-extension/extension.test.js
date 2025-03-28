const vscode = require('vscode');
const net = require('net');
const path = require('path');
const os = require('os');
const fs = require('fs');
const { exec } = require('child_process');
const assert = require('assert');

const gunHostDir = path.join(os.homedir(), '.gunhost');
const gunSocketPath = path.join(gunHostDir, 'gun.sock');

suite('VSCode Extension Tests', () => {
  let gunClient;

  suiteSetup(() => {
    if (!fs.existsSync(gunHostDir)) {
      fs.mkdirSync(gunHostDir);
    }
  });

  suiteTeardown(() => {
    if (fs.existsSync(gunHostDir)) {
      fs.rmdirSync(gunHostDir, { recursive: true });
    }
  });

  test('should connect to Gun service', (done) => {
    exec('node src/gunhost.js start', (err, stdout, stderr) => {
      if (err) {
        done(err);
        return;
      }

      gunClient = net.createConnection(gunSocketPath, () => {
        assert.ok(gunClient);
        done();
      });

      gunClient.on('error', (err) => {
        done(err);
      });
    });
  });

  test('should prompt to install Gun service if missing', (done) => {
    if (fs.existsSync(gunSocketPath)) {
      fs.unlinkSync(gunSocketPath);
    }

    const installOption = 'Install Gun Service';
    vscode.window.showErrorMessage = (message, ...items) => {
      assert.strictEqual(message, 'Gun service is not installed');
      assert.strictEqual(items[0], installOption);
      done();
      return Promise.resolve(installOption);
    };

    const extension = require('./extension');
    extension.activate({ subscriptions: [] });
  });

  test('should sync workspace data with Gun service', (done) => {
    exec('node src/gunhost.js start', (err, stdout, stderr) => {
      if (err) {
        done(err);
        return;
      }

      gunClient = net.createConnection(gunSocketPath, () => {
        const extension = require('./extension');
        extension.syncWorkspaceData = () => {
          assert.ok(true);
          done();
        };

        extension.activate({ subscriptions: [] });
        vscode.commands.executeCommand('extension.syncWorkspaceData');
      });

      gunClient.on('error', (err) => {
        done(err);
      });
    });
  });
});
