# Knowledge Engine Interactive Tutorial

Welcome to the Knowledge Engine interactive tutorial! This tutorial will guide you through the process of using the Knowledge Engine framework. Follow the step-by-step instructions and try out the interactive code examples to get hands-on experience.

## Prerequisites

Before you start, make sure you have the following installed on your system:

- Node.js
- Deno
- Git

## Step 1: Setting Up the Project

1. **Clone the Repository**: Clone the Knowledge Engine repository to your local machine.
   ```bash
   git clone https://github.com/plures/kno-eng.git
   ```

2. **Install Dependencies**: Navigate to the project directory and install the necessary dependencies.
   ```bash
   cd kno-eng
   npm install
   ```

3. **Start the Gun.js Service**: Use the following command to start the Gun.js service.
   ```bash
   npm start
   ```

## Step 2: Using the Gun.js Service

1. **Save Data**: Use the following code to save data to the Gun.js database.
   ```html
   <script>
     import Gun from 'gun';

     const gun = Gun();

     function saveData() {
       const key = document.getElementById('keyInput').value;
       const value = document.getElementById('valueInput').value;

       gun.get(key).put({ value }, (ack) => {
         if (ack.err) {
           console.error('Error saving data:', ack.err);
         } else {
           console.log('Data saved successfully');
         }
       });
     }
   </script>

   <div>
     <label for="keyInput">Key:</label>
     <input id="keyInput" type="text">
   </div>
   <div>
     <label for="valueInput">Value:</label>
     <input id="valueInput" type="text">
   </div>
   <button onclick="saveData()">Save</button>
   ```

2. **Load Data**: Use the following code to load data from the Gun.js database.
   ```html
   <script>
     import Gun from 'gun';

     const gun = Gun();

     function loadData() {
       const key = document.getElementById('keyInput').value;

       gun.get(key).once((data) => {
         if (data) {
           document.getElementById('valueInput').value = data.value;
           console.log('Data loaded successfully');
         } else {
           console.error('No data found for key:', key);
         }
       });
     }
   </script>

   <div>
     <label for="keyInput">Key:</label>
     <input id="keyInput" type="text">
   </div>
   <button onclick="loadData()">Load</button>
   ```

## Step 3: Using the VSCode Extension

1. **Install the Extension**: Open VSCode, go to the Extensions view, and install the Knowledge Engine extension.

2. **Connect to Gun Service**: Use the command palette (`Ctrl+Shift+P`) and run the command `Connect to Gun Service`.

3. **Sync Workspace Data**: Use the command palette (`Ctrl+Shift+P`) and run the command `Sync Workspace Data`.

## Step 4: Using the Mobile Clients

### CLI Client

1. **Start the CLI Client**: Use the following command to start the CLI client.
   ```bash
   deno run src/mobile-client/cli.ts start
   ```

2. **Stop the CLI Client**: Use the following command to stop the CLI client.
   ```bash
   deno run src/mobile-client/cli.ts stop
   ```

3. **Check CLI Client Status**: Use the following command to check the status of the CLI client.
   ```bash
   deno run src/mobile-client/cli.ts status
   ```

### GUI Client

1. **Start the GUI Client**: Use the following command to start the GUI client.
   ```bash
   npm run dev
   ```

2. **Access the GUI Client**: Open your browser and navigate to `http://localhost:5000`.

## Step 5: Interactive Code Examples with Svelte

1. **Save Data with Svelte**: Use the following Svelte component to save data to the Gun.js database.
   ```svelte
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
   ```

## Conclusion

Congratulations! You have completed the Knowledge Engine interactive tutorial. You should now have a good understanding of how to set up and use the Knowledge Engine framework. Feel free to explore the project further and contribute to its development. Happy coding!
