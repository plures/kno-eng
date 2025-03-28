import { connectWebSocket, connectHttp, connectSocket } from './connections.ts';

const args = Deno.args;

const startClient = async () => {
  try {
    await connectWebSocket();
    await connectHttp();
    await connectSocket();
    console.log('Connected to Gun.js instance via WebSocket, HTTP, and local socket');
  } catch (error) {
    console.error('Failed to connect to Gun.js instance:', error);
  }
};

const stopClient = () => {
  console.log('Stopping client is not implemented yet');
};

const getStatus = () => {
  console.log('Status check is not implemented yet');
};

switch (args[0]) {
  case 'start':
    startClient();
    break;
  case 'stop':
    stopClient();
    break;
  case 'status':
    getStatus();
    break;
  default:
    console.log('Usage: deno run cli.ts [start|stop|status]');
    break;
}
