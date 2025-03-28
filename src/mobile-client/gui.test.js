import { render, screen } from '@testing-library/svelte';
import { connectionStatus } from './gui.js';
import Gui from './Gui.svelte';

describe('Mobile Frontend', () => {
  test('should connect to Gun.js instance via WebSocket, HTTP, and local socket', async () => {
    render(Gui);

    expect(screen.getByText('Connecting...')).toBeInTheDocument();

    await new Promise((resolve) => setTimeout(resolve, 1000)); // wait for connection

    expect(screen.getByText('Connected')).toBeInTheDocument();
  });

  test('should handle connection failure', async () => {
    connectionStatus.set('Failed to connect');
    render(Gui);

    expect(screen.getByText('Failed to connect')).toBeInTheDocument();
  });
});
