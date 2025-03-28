import { assertEquals } from "https://deno.land/std/testing/asserts.ts";
import { connectWebSocket, connectHttp, connectSocket } from "./connections.ts";

Deno.test("CLI start command should connect to Gun.js instance", async () => {
  const originalConsoleLog = console.log;
  const logs = [];
  console.log = (msg) => logs.push(msg);

  await import("./cli.js").then((cli) => {
    cli.startClient();
  });

  assertEquals(logs.includes("Connected to Gun.js instance via WebSocket, HTTP, and local socket"), true);

  console.log = originalConsoleLog;
});

Deno.test("CLI stop command should log stop message", () => {
  const originalConsoleLog = console.log;
  const logs = [];
  console.log = (msg) => logs.push(msg);

  import("./cli.js").then((cli) => {
    cli.stopClient();
  });

  assertEquals(logs.includes("Stopping client is not implemented yet"), true);

  console.log = originalConsoleLog;
});

Deno.test("CLI status command should log status message", () => {
  const originalConsoleLog = console.log;
  const logs = [];
  console.log = (msg) => logs.push(msg);

  import("./cli.js").then((cli) => {
    cli.getStatus();
  });

  assertEquals(logs.includes("Status check is not implemented yet"), true);

  console.log = originalConsoleLog;
});
