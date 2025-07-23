# Knowledge Engine (kno-eng)

**Intelligent Knowledge Management Across All Platforms**

Knowledge Engine (kno-eng) is a comprehensive knowledge management platform that learns from your coding patterns, prevents errors, and synchronizes knowledge across VS Code, mobile devices, and web applications. 

## 🚀 Quick Start

### Prerequisites

- **Node.js** (v16 or higher) - [Download here](https://nodejs.org/)
- **VS Code** or **Cursor** - [Download here](https://code.visualstudio.com/)
- **Git** - [Download here](https://git-scm.com/)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-org/kno-eng.git
   cd kno-eng
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Install VS Code Extension**:
   ```bash
   cd src/vscode-extension/kno-eng-extension
   npm install
   npm run build
   ```

## 📦 Project Components

### 🎯 VS Code Extension
**Location**: `src/vscode-extension/kno-eng-extension/`

The core Knowledge Engine extension for VS Code and Cursor that provides:
- **Auto-learning** from coding errors and fixes
- **Pattern recognition** and intelligent suggestions
- **MCP integration** for AI agent collaboration
- **P2P synchronization** via GUN.js
- **Multi-language support** (JavaScript, TypeScript, Python, PowerShell, C#, etc.)

**Setup**:
```bash
cd src/vscode-extension/kno-eng-extension
npm install
npm run build
```

### 📱 Mobile Client
**Location**: `src/mobile-client/`

Mobile application for accessing knowledge on-the-go (currently in development).

**Setup**:
```bash
cd src/mobile-client
npm install
npm start
```

### 🌐 Landing Page
**Location**: `src/landing-page/`

Marketing website and user onboarding portal (currently in development).

**Setup**:
```bash
cd src/landing-page
npm install
npm run dev
```

### 🔄 GUN.js Service
**Location**: `src/gunhost.js`

Shared P2P server for data synchronization across all platforms.

**Setup**:
```bash
npm start  # From project root
```

## 🎯 VS Code Extension Usage

### Installation

1. **Build and Install**:
   ```bash
   cd src/vscode-extension/kno-eng-extension
   npm install
   npm run build
   ```

2. **Load in VS Code**:
   - Open VS Code
   - Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
   - Run "Developer: Reload Window"

### Key Commands

- **`Knowledge Engine: Learn from Error`** - Learn from coding errors
- **`Knowledge Engine: Show MCP Status`** - Check MCP server status
- **`Knowledge Engine: Start MCP Server`** - Start MCP server for AI integration
- **`Knowledge Engine: Register MCP with Cursor`** - Register with Cursor IDE
- **`Knowledge Engine: Create Note`** - Create knowledge notes
- **`Knowledge Engine: Generate Report`** - Generate knowledge reports

### MCP Integration

The extension includes a comprehensive MCP (Model Context Protocol) server that allows AI agents to access the knowledge engine:

- **Auto-registration** with Cursor and other MCP clients
- **Real-time tools** for learning, pattern matching, and knowledge retrieval
- **Cross-platform sync** via GUN.js P2P network

For detailed MCP setup, see `src/vscode-extension/kno-eng-extension/MCP_INTEGRATION_GUIDE.md`

## 📱 Mobile Client Usage

### CLI Client

**Setup**:
```bash
cd src/mobile-client
npm install
```

**Usage**:
```bash
# Start CLI client
node cli.js start

# Check status
node cli.js status

# Stop client
node cli.js stop
```

### GUI Client

**Setup**:
```bash
cd src/mobile-client
npm install
```

**Usage**:
```bash
# Start GUI client
node gui.js

# Access at http://localhost:5000
```

## 🌐 Landing Page

**Setup**:
```bash
cd src/landing-page
npm install
npm run dev
```

**Access**: Open your browser and navigate to `http://localhost:3000`

## 🔧 Development

### Project Structure

This is a **monorepo** containing multiple interconnected projects:

- **`src/vscode-extension/`** - VS Code extension (main component)
- **`src/mobile-client/`** - Mobile application
- **`src/landing-page/`** - Marketing website
- **`src/gunhost.js`** - Shared P2P server

For detailed project structure, see `ProjectStructure.md`

### Building All Components

```bash
# Build VS Code extension
cd src/vscode-extension/kno-eng-extension
npm run build

# Build mobile client
cd src/mobile-client
npm run build

# Build landing page
cd src/landing-page
npm run build
```

### Testing

```bash
# Test VS Code extension
cd src/vscode-extension/kno-eng-extension
npm test

# Test mobile client
cd src/mobile-client
npm test

# Test landing page
cd src/landing-page
npm test
```

## 📚 Documentation

- **`ProjectStructure.md`** - Detailed project structure and architecture
- **`ProjectPlan.md`** - Comprehensive project planning and roadmap
- **`DevelopmentProcess.md`** - Development workflow and guidelines
- **`ValidationChecklist.md`** - Quality assurance and testing checklist
- **`IntegrationPlan.md`** - Integration strategy and progress

### Extension Documentation

- **`src/vscode-extension/kno-eng-extension/MCP_INTEGRATION_GUIDE.md`** - MCP server setup and usage
- **`src/vscode-extension/kno-eng-extension/AGENT_ENGAGEMENT_GUIDE.md`** - AI agent integration
- **`src/vscode-extension/kno-eng-extension/GUN_INTEGRATION_GUIDE.md`** - P2P synchronization

## 🤝 Contributing

1. Read `DevelopmentProcess.md` and `DevelopmentRules.md`
2. Fork the repository
3. Create a feature branch
4. Make your changes
5. Run tests and validation
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the `LICENSE` file for details.

