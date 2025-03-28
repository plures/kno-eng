const vscode = require('vscode');
const net = require('net');
const path = require('path');
const os = require('os');
const fs = require('fs');
const { exec } = require('child_process');

const gunHostDir = path.join(os.homedir(), '.gunhost');
const gunSocketPath = path.join(gunHostDir, 'gun.sock');

function activate(context) {
  let gunClient;

  const connectToGunService = () => {
    if (!fs.existsSync(gunSocketPath)) {
      promptInstallGunService();
      return;
    }

    gunClient = net.createConnection(gunSocketPath, () => {
      vscode.window.showInformationMessage('Connected to Gun service');
    });

    gunClient.on('error', (err) => {
      vscode.window.showErrorMessage(`Gun service connection error: ${err.message}`);
    });
  };

  const promptInstallGunService = () => {
    const installOption = 'Install Gun Service';
    vscode.window.showErrorMessage('Gun service is not installed', installOption).then((selection) => {
      if (selection === installOption) {
        installGunService();
      }
    });
  };

  const installGunService = () => {
    exec('node src/gunhost.js start', (err, stdout, stderr) => {
      if (err) {
        vscode.window.showErrorMessage(`Failed to install Gun service: ${err.message}`);
        return;
      }
      vscode.window.showInformationMessage('Gun service installed successfully');
      connectToGunService();
    });
  };

  const syncWorkspaceData = () => {
    if (!gunClient) {
      vscode.window.showErrorMessage('Not connected to Gun service');
      return;
    }

    // Implement sync logic here
    vscode.window.showInformationMessage('Workspace data synced with Gun service');
  };

  context.subscriptions.push(
    vscode.commands.registerCommand('extension.connectToGunService', connectToGunService),
    vscode.commands.registerCommand('extension.syncWorkspaceData', syncWorkspaceData)
  );

  connectToGunService();
}

function deactivate() {
  if (gunClient) {
    gunClient.end();
  }
}

module.exports = {
  activate,
  deactivate
};
