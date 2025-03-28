<script>
  import { onMount } from 'svelte';
  import Gun from 'gun';

  let key = '';
  let value = '';
  let data = {};

  const gun = Gun();

  onMount(() => {
    gun.get('data').on((d) => {
      data = d;
    });
  });

  function saveData() {
    gun.get('data').put({ [key]: value });
  }

  function loadData() {
    value = data[key] || '';
  }
</script>

<main>
  <h1>Knowledge Engine</h1>
  <div>
    <label for="keyInput">Key:</label>
    <input id="keyInput" bind:value={key} />
  </div>
  <div>
    <label for="valueInput">Value:</label>
    <input id="valueInput" bind:value={value} />
  </div>
  <div>
    <button on:click={saveData}>Save</button>
    <button on:click={loadData}>Load</button>
  </div>
  <div>
    <h2>Data</h2>
    <pre>{JSON.stringify(data, null, 2)}</pre>
  </div>
</main>

<style>
  main {
    font-family: Arial, sans-serif;
    padding: 2rem;
    max-width: 600px;
    margin: 0 auto;
  }

  h1 {
    text-align: center;
  }

  div {
    margin-bottom: 1rem;
  }

  label {
    display: block;
    margin-bottom: 0.5rem;
  }

  input {
    width: 100%;
    padding: 0.5rem;
    box-sizing: border-box;
  }

  button {
    padding: 0.5rem 1rem;
    margin-right: 0.5rem;
  }

  pre {
    background-color: #f4f4f4;
    padding: 1rem;
    border-radius: 4px;
  }
</style>
