# Knowledge Engine Development Guide

## 🚀 Getting Started

### Prerequisites

- **Node.js** (v16 or higher)
- **npm** (v8 or higher)
- **Git**
- **VS Code** or **Cursor** (for extension development)

### Initial Setup

1. **Clone and install**:
   ```bash
   git clone https://github.com/your-org/kno-eng.git
   cd kno-eng
   npm run install:all
   ```

2. **Start development**:
   ```bash
   # Start all components in development mode
   npm run dev:all
   
   # Or start individual components
   npm run dev:extension  # VS Code extension
   npm run dev:mobile     # Mobile client
   npm run dev:landing    # Landing page
   ```

## 📁 Project Structure

```
kno-eng/
├── 📁 src/
│   ├── 📁 vscode-extension/kno-eng-extension/  # Main extension
│   ├── 📁 mobile-client/                       # Mobile app
│   ├── 📁 landing-page/                        # Marketing website
│   └── 📄 gunhost.js                           # Shared P2P server
├── 📄 package.json                             # Root workspace config
├── 📄 ProjectStructure.md                      # Detailed structure
└── 📄 README.md                                # Main documentation
```

## 🔧 Development Workflow

### Root-Level Commands

```bash
# Install all dependencies
npm run install:all

# Build all projects
npm run build:all

# Test all projects
npm run test:all

# Development mode (all projects)
npm run dev:all

# Clean all projects
npm run clean

# Lint all projects
npm run lint:all
```

### Individual Project Commands

#### VS Code Extension
```bash
cd src/vscode-extension/kno-eng-extension

# Development
npm run watch          # Watch mode
npm run build          # Build extension
npm run package        # Create VSIX package
npm test               # Run tests

# MCP Testing
node test-mcp-connection.js  # Test MCP server
```

#### Mobile Client
```bash
cd src/mobile-client

# Development
npm start              # Start development server
npm run build          # Build for production
npm test               # Run tests

# CLI Usage
node cli.js start      # Start CLI client
node cli.js status     # Check status
node cli.js stop       # Stop CLI client
```

#### Landing Page
```bash
cd src/landing-page

# Development
npm run dev            # Start development server
npm run build          # Build for production
npm test               # Run tests
```

## 🎯 VS Code Extension Development

### Key Features to Develop

1. **Auto Memory Learning**
   - Error pattern recognition
   - Fix suggestion system
   - Pattern effectiveness tracking

2. **MCP Integration**
   - Server implementation
   - AI agent tools
   - Cursor integration

3. **GUN.js P2P Sync**
   - Real-time synchronization
   - Conflict resolution
   - Offline support

4. **Multi-language Support**
   - Language adapters
   - Snippet generation
   - Pattern matching

### Development Commands

```bash
cd src/vscode-extension/kno-eng-extension

# Build and test
npm run build
npm test

# Package extension
npm run package

# Test MCP server
node test-mcp-connection.js

# Check MCP status in VS Code
# Command Palette → "Knowledge Engine: Show MCP Status"
```

### Testing MCP Integration

1. **Start MCP server**:
   ```bash
   # In VS Code Command Palette
   Knowledge Engine: Start MCP Server
   ```

2. **Register with Cursor**:
   ```bash
   # In VS Code Command Palette
   Knowledge Engine: Register MCP with Cursor
   ```

3. **Test connection**:
   ```bash
   node test-mcp-connection.js
   ```

4. **Use with Cursor**:
   - Ask Cursor: "Learn from this error: TypeError: Cannot read property of undefined"
   - Check if Cursor responds with knowledge engine suggestions

## 📱 Mobile Client Development

### Current State
- Basic CLI and GUI structure
- GUN.js integration ready
- Test framework in place

### Development Priorities
1. **Knowledge Sync**
   - Connect to GUN.js network
   - Sync patterns and notes
   - Offline storage

2. **User Interface**
   - Pattern browsing
   - Note creation/editing
   - Search functionality

3. **Platform Support**
   - React Native or Flutter
   - iOS and Android
   - Progressive Web App

## 🌐 Landing Page Development

### Current State
- Basic Svelte app structure
- Development server ready

### Development Priorities
1. **Marketing Content**
   - Feature showcase
   - Pricing information
   - User testimonials

2. **User Onboarding**
   - Installation guides
   - Quick start tutorials
   - Interactive demos

3. **Documentation**
   - API documentation
   - Integration guides
   - Troubleshooting

## 🔄 Shared Components

### GUN.js Server (`src/gunhost.js`)

**Purpose**: P2P synchronization server for all components

**Usage**:
```bash
# Start server
npm start

# Check status
npm run status

# Stop server
npm stop
```

**Configuration**:
- Port: 8765 (default)
- Host: localhost
- Storage: `.vscode/kno-eng/gun/`

## 🧪 Testing Strategy

### Unit Testing
```bash
# Test all components
npm run test:all

# Test individual components
npm run test:extension
npm run test:mobile
npm run test:landing
```

### Integration Testing
```bash
# Test MCP integration
cd src/vscode-extension/kno-eng-extension
node test-mcp-connection.js

# Test GUN.js integration
cd src/vscode-extension/kno-eng-extension
node test-gun-integration.js
```

### End-to-End Testing
```bash
# Test extension in VS Code
cd src/vscode-extension/kno-eng-extension
npm run test:extension-automated
```

## 📦 Building and Packaging

### VS Code Extension
```bash
cd src/vscode-extension/kno-eng-extension

# Build
npm run build

# Package
npm run package

# Install locally
code --install-extension kno-eng-extension-0.1.0.vsix
```

### Mobile Client
```bash
cd src/mobile-client

# Build for production
npm run build

# Package for distribution
npm run package
```

### Landing Page
```bash
cd src/landing-page

# Build for production
npm run build

# Deploy to GitHub Pages
npm run deploy
```

## 🚀 Deployment

### VS Code Extension
1. **Build and package**:
   ```bash
   cd src/vscode-extension/kno-eng-extension
   npm run build
   npm run package
   ```

2. **Publish to VS Code Marketplace**:
   - Create publisher account
   - Use `vsce publish` command
   - Follow marketplace guidelines

### Mobile App
1. **Build for platforms**:
   ```bash
   cd src/mobile-client
   npm run build:ios
   npm run build:android
   ```

2. **Deploy to app stores**:
   - iOS App Store
   - Google Play Store
   - Progressive Web App

### Landing Page
1. **Build and deploy**:
   ```bash
   cd src/landing-page
   npm run build
   npm run deploy
   ```

## 🔍 Debugging

### VS Code Extension
1. **Enable debugging**:
   - Open extension in VS Code
   - Press F5 to start debugging
   - Check Output panel for logs

2. **MCP debugging**:
   ```bash
   # Check MCP logs
   # Output panel → "Knowledge Engine"
   
   # Test MCP connection
   node test-mcp-connection.js
   ```

### GUN.js Debugging
1. **Check server status**:
   ```bash
   npm run status
   ```

2. **View server logs**:
   ```bash
   npm start
   # Check console output
   ```

## 📚 Documentation

### Key Documents
- **`ProjectStructure.md`** - Detailed project architecture
- **`ProjectPlan.md`** - Comprehensive project roadmap
- **`ValidationChecklist.md`** - Quality assurance checklist
- **`IntegrationPlan.md`** - Integration strategy

### Extension Documentation
- **`MCP_INTEGRATION_GUIDE.md`** - MCP server setup and usage
- **`AGENT_ENGAGEMENT_GUIDE.md`** - AI agent integration
- **`GUN_INTEGRATION_GUIDE.md`** - P2P synchronization

## 🤝 Contributing

### Development Process
1. **Read guidelines**: `DevelopmentProcess.md` and `DevelopmentRules.md`
2. **Create feature branch**: `git checkout -b feature/your-feature`
3. **Make changes**: Follow coding standards
4. **Test thoroughly**: Run all relevant tests
5. **Update documentation**: Keep docs in sync
6. **Submit PR**: Create pull request with description

### Code Standards
- **TypeScript**: Use for VS Code extension
- **JavaScript**: Use for mobile and web components
- **Svelte**: Use for UI components
- **Testing**: Write tests for new features
- **Documentation**: Update relevant docs

### Commit Messages
Use conventional commit format:
```
feat: add new MCP tool for pattern learning
fix: resolve GUN.js connection timeout
docs: update MCP integration guide
test: add tests for mobile client CLI
```

## 🎯 Next Steps

### Immediate Priorities
1. **Complete MCP integration** - Ensure AI agents can access knowledge
2. **Enhance mobile client** - Build full mobile app functionality
3. **Develop landing page** - Create marketing website
4. **Improve documentation** - Comprehensive user guides

### Future Enhancements
1. **Backend API** - Centralized API for advanced features
2. **Desktop app** - Native desktop application
3. **Browser extension** - Web browser integration
4. **Plugin system** - Extensible architecture
5. **Advanced AI** - Machine learning improvements

## 📞 Support

- **Issues**: Create GitHub issues for bugs and feature requests
- **Discussions**: Use GitHub Discussions for questions
- **Documentation**: Check project docs for solutions
- **Community**: Join our community channels

---

**Happy coding! 🚀** 