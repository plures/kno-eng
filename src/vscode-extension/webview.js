import { onMount } from 'svelte';
import { writable } from 'svelte/store';

const vscode = acquireVsCodeApi();

const messageStore = writable([]);

onMount(() => {
  window.addEventListener('message', event => {
    const message = event.data;
    messageStore.update(messages => [...messages, message]);
  });
});

function sendMessage(message) {
  vscode.postMessage(message);
}

export { messageStore, sendMessage };
