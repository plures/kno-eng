import { onMount } from 'svelte';
import { writable } from 'svelte/store';
import { connectWebSocket, connectHttp, connectSocket } from './connections.ts';

const connectionStatus = writable('Disconnected');

onMount(async () => {
  try {
    await connectWebSocket();
    await connectHttp();
    await connectSocket();
    connectionStatus.set('Connected');
  } catch (error) {
    console.error('Failed to connect to Gun.js instance:', error);
    connectionStatus.set('Failed to connect');
  }
});

export { connectionStatus };
