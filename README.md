# kno-eng Pronounced Knowing
is a Knowledge Engine framework. 

## Gun.js Service Setup and Usage

### Setup

1. **Install Node.js**: Ensure you have Node.js installed on your system. You can download it from [Node.js official website](https://nodejs.org/).

2. **Clone the Repository**: Clone this repository to your local machine.

3. **Install Dependencies**: Navigate to the project directory and run the following command to install the necessary dependencies:
   ```bash
   npm install
   ```

4. **Start the Gun.js Service**: Use the following command to start the Gun.js service:
   ```bash
   npm start
   ```

### Usage

- **Start the Service**: 
  ```bash
  npm start
  ```

- **Stop the Service**: 
  ```bash
  npm stop
  ```

- **Check Service Status**: 
  ```bash
  npm run status
  ```

## VSCode Extension Setup and Usage

### Setup

1. **Install VSCode**: Ensure you have Visual Studio Code installed on your system. You can download it from [VSCode official website](https://code.visualstudio.com/).

2. **Install the Extension**: Open VSCode, go to the Extensions view by clicking on the Extensions icon in the Activity Bar on the side of the window or by pressing `Ctrl+Shift+X`. Search for the extension and install it.

### Usage

- **Connect to Gun Service**: Use the command palette (`Ctrl+Shift+P`) and run the command `Connect to Gun Service`.

- **Sync Workspace Data**: Use the command palette (`Ctrl+Shift+P`) and run the command `Sync Workspace Data`.

## Mobile Clients Setup and Usage

### CLI Client

#### Setup

1. **Install Deno**: Ensure you have Deno installed on your system. You can download it from [Deno official website](https://deno.land/).

2. **Clone the Repository**: Clone this repository to your local machine.

3. **Navigate to CLI Directory**: Navigate to the `src/mobile-client` directory.

### Usage

- **Start the CLI Client**: 
  ```bash
  deno run cli.ts start
  ```

- **Stop the CLI Client**: 
  ```bash
  deno run cli.ts stop
  ```

- **Check CLI Client Status**: 
  ```bash
  deno run cli.ts status
  ```

### GUI Client

#### Setup

1. **Install Node.js**: Ensure you have Node.js installed on your system. You can download it from [Node.js official website](https://nodejs.org/).

2. **Clone the Repository**: Clone this repository to your local machine.

3. **Navigate to GUI Directory**: Navigate to the `src/mobile-client` directory.

4. **Install Dependencies**: Run the following command to install the necessary dependencies:
   ```bash
   npm install
   ```

### Usage

- **Start the GUI Client**: 
  ```bash
  npm run dev
  ```

- **Access the GUI Client**: Open your browser and navigate to `http://localhost:5000`.

