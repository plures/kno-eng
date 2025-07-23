# Knowledge Engine (kno-eng) Project Structure

## Overview

Knowledge Engine (kno-eng) is a comprehensive knowledge management platform implemented as a monorepo containing multiple interconnected projects. The platform provides intelligent learning, pattern recognition, and knowledge sharing across different development environments and devices.

## Repository Structure

```
kno-eng/
├── 📁 docs/                          # Project documentation
├── 📁 src/                           # Source code for all projects
│   ├── 📁 vscode-extension/          # VS Code Extension
│   │   └── 📁 kno-eng-extension/     # Main extension project
│   ├── 📁 mobile-client/             # Mobile Application
│   ├── 📁 landing-page/              # Website/Landing Page
│   └── 📁 gunhost.js                 # Shared GUN.js server
├── 📁 .github/                       # GitHub workflows and templates
├── 📁 .vscode/                       # VS Code workspace settings
├── 📁 .cursor/                       # Cursor IDE settings
├── 📄 README.md                      # Main project README
├── 📄 ProjectPlan.md                 # Detailed project planning
├── 📄 DevelopmentProcess.md          # Development workflow
├── 📄 DevelopmentRules.md            # Coding standards and rules
├── 📄 ValidationChecklist.md         # Quality assurance checklist
├── 📄 IntegrationPlan.md             # Integration strategy
├── 📄 INTEGRATION_PROGRESS.md        # Integration progress tracking
├── 📄 package.json                   # Root package configuration
├── 📄 LICENSE                        # MIT License
└── 📄 .gitignore                     # Git ignore rules
```

## Project Components

### 1. VS Code Extension (`src/vscode-extension/kno-eng-extension/`)

**Purpose**: Provides intelligent code assistance, error prevention, and knowledge management directly within VS Code and Cursor.

**Key Features**:
- Auto-learning from coding errors and fixes
- Pattern recognition and suggestion system
- MCP (Model Context Protocol) server for AI agent integration
- GUN.js P2P synchronization
- Multi-language support (JavaScript, TypeScript, Python, PowerShell, C#, etc.)
- Note management and knowledge base
- Real-time code validation and diagnostics

**Structure**:
```
kno-eng-extension/
├── 📁 src/                           # TypeScript source code
│   ├── 📁 core/                      # Core engine and managers
│   ├── 📁 commands/                  # VS Code commands
│   ├── 📁 integration/               # MCP, Cursor, Copilot integration
│   ├── 📁 providers/                 # Language service providers
│   ├── 📁 ui/                        # Svelte-based UI components
│   └── 📁 billing/                   # Subscription and billing features
├── 📁 languages/                     # Language-specific snippets
├── 📁 images/                        # Extension icons and assets
├── 📁 test/                          # Test files
├── 📁 out/                           # Compiled JavaScript
├── 📄 package.json                   # Extension manifest
├── 📄 tsconfig.json                  # TypeScript configuration
└── 📄 *.md                           # Documentation and guides
```

### 2. Mobile Client (`src/mobile-client/`)

**Purpose**: Mobile application for accessing and managing knowledge on-the-go.

**Current State**: Basic CLI and GUI structure in place
**Future Development**: Full mobile app with knowledge sync, note-taking, and pattern viewing

**Structure**:
```
mobile-client/
├── 📄 cli.js                         # Command-line interface
├── 📄 cli.test.js                    # CLI tests
├── 📄 gui.js                         # GUI application
├── 📄 gui.test.js                    # GUI tests
└── 📄 package.json                   # Mobile app configuration
```

### 3. Landing Page (`src/landing-page/`)

**Purpose**: Marketing website and user onboarding portal.

**Current State**: Basic Svelte app structure
**Future Development**: Full marketing site with features showcase, pricing, and documentation

**Structure**:
```
landing-page/
├── 📄 app.js                         # Main application entry
├── 📄 App.svelte                     # Root Svelte component
├── 📄 App.test.js                    # App tests
├── 📄 index.html                     # HTML entry point
├── 📄 styles.css                     # Global styles
└── 📄 package.json                   # Web app configuration
```

### 4. Shared Components

**GUN.js Server** (`src/gunhost.js`): Shared P2P server for data synchronization across all projects.

## Development Workflow

### Monorepo Management

1. **Root Level**: Project-wide configuration, documentation, and shared tools
2. **Component Level**: Each subproject (`vscode-extension`, `mobile-client`, `landing-page`) has its own:
   - Package configuration
   - Build scripts
   - Test suites
   - Documentation

### Cross-Project Dependencies

- **Shared Knowledge Base**: All projects can access the same knowledge patterns and data
- **GUN.js Sync**: Real-time synchronization across all platforms
- **MCP Protocol**: AI agents can access knowledge from any platform
- **Common APIs**: Shared interfaces for knowledge operations

### Build and Deployment

Each subproject can be built and deployed independently:

```bash
# Build VS Code extension
cd src/vscode-extension/kno-eng-extension
npm run build

# Build mobile app
cd src/mobile-client
npm run build

# Build landing page
cd src/landing-page
npm run build
```

## Technology Stack

### Core Technologies
- **TypeScript**: Primary language for VS Code extension
- **JavaScript**: Mobile client and web components
- **Svelte**: UI framework for web and extension
- **GUN.js**: P2P database and synchronization
- **Node.js**: Runtime environment

### Development Tools
- **VS Code/Cursor**: Primary development environment
- **Git**: Version control
- **npm**: Package management
- **TypeScript**: Type safety and tooling

### Integration Technologies
- **MCP (Model Context Protocol)**: AI agent integration
- **VS Code Extension API**: Extension development
- **P2P Networking**: GUN.js for decentralized sync

## Future Expansion

### Planned Components
1. **Backend API**: RESTful API for centralized operations
2. **Desktop App**: Native desktop application
3. **Browser Extension**: Web browser integration
4. **CLI Tool**: Command-line knowledge management
5. **API SDK**: Libraries for third-party integrations

### Scalability Considerations
- **Microservices**: Each component can be deployed independently
- **Plugin System**: Extensible architecture for custom integrations
- **API Gateway**: Centralized API management
- **Monitoring**: Cross-platform analytics and monitoring

## Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-org/kno-eng.git
   cd kno-eng
   ```

2. **Install dependencies**:
   ```bash
   npm install
   cd src/vscode-extension/kno-eng-extension && npm install
   cd ../../mobile-client && npm install
   cd ../landing-page && npm install
   ```

3. **Start development**:
   ```bash
   # VS Code Extension
   cd src/vscode-extension/kno-eng-extension
   npm run watch

   # Mobile Client
   cd src/mobile-client
   npm start

   # Landing Page
   cd src/landing-page
   npm run dev
   ```

## Contributing

See `DevelopmentProcess.md` and `DevelopmentRules.md` for detailed contribution guidelines.

## License

MIT License - see `LICENSE` file for details. 