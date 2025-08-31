# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

Beacon is a server manager and config editor for the games Ark: Survival Evolved, Ark: Survival Ascended, and Palworld. It's built using Xojo (cross-platform IDE) and supports macOS, Windows, and Linux.

## Key Development Commands

### Building the Application

The main application builds are configured through Xojo's Build Automation system in `Project/Build Automation.xojo_code`. Builds are platform-specific:

- **macOS**: Uses automated signing, asset compilation with `actool`, and Sparkle framework integration
- **Windows**: Includes PowerShell-based resource downloading and exe installer creation  
- **Linux**: Basic build with resource copying

### Running Tests

Tests are integrated into the application startup in debug mode:
```bash
# Tests run automatically when launching debug builds
# Tests are defined in Project/Modules/Tests.xojo_code
```

The test suite includes:
- JSON parsing/generation
- Blueprint serialization/deserialization
- Encryption/decryption portability
- UUID generation
- String manipulation
- Configuration validation
- ArkML parsing

### Website Development

For the PHP/JavaScript website components:
```bash
# Navigate to Website directory
cd Website/

# Install JavaScript dependencies
npm install

# Build frontend assets
npx webpack

# Install PHP dependencies  
composer install

# Run local Jekyll documentation server
cd ../docs/
bundle install
bundle exec jekyll serve
```

### Documentation

The `docs/` directory contains Jekyll-based documentation:
```bash
cd docs/
bundle exec jekyll serve --watch
# Access at http://localhost:4000
```

## Code Architecture

### Core Module Structure

The project follows a modular architecture centered around game support:

**Main Application (`Project/`)**
- `App.xojo_code`: Main application class, handles startup, menu events, and lifecycle
- `MainWindow.xojo_window`: Primary UI window with document management
- `Build Automation.xojo_code`: Cross-platform build configuration

**Core Framework (`Project/Modules/`)**
- `Beacon.xojo_code`: Core utilities, data structures, and common functionality
- `BeaconAPI.xojo_code`: API client for Beacon web services
- `BeaconUI.xojo_code`: UI utilities and custom controls
- `BeaconEncryption.xojo_code`: Cryptographic operations and secure data handling

**Game Support Architecture (`Project/Modules/Game Support/`)**
- `Ark.xojo_code`: Ark: Survival Evolved game logic and data structures
- `ArkSA.xojo_code`: Ark: Survival Ascended (separate module due to significant differences)
- `Palworld.xojo_code`: Palworld game support
- `SDTD.xojo_code`: 7 Days to Die game support

Each game module contains:
- **DataSource**: Database connections and blueprint retrieval
- **Project**: Game-specific project containers
- **Configs**: Configuration editors for each game type
- **Blueprint classes**: Game objects (Engrams, Creatures, SpawnPoints, LootContainers)
- **Import/Export**: File format handlers

**Supporting Components**
- `FrameworkExtensions.xojo_code`: Xojo framework extensions and utilities
- `UserCloud.xojo_code`: Cloud synchronization and user data management
- `UpdatesKit.xojo_code`: Application update system
- `NotificationKit.xojo_code`: Event notification system
- `Tests.xojo_code`: Automated testing framework

### UI Architecture

**Views Structure (`Project/Views/`)**
- Game-specific view folders (Ark/, ArkSA/, Palworld/, etc.)
- Config Editors: Specialized UI for each configuration type
- Document management views
- Import/export dialogs

**Custom Controls (`Project/Custom Controls/`)**
- `BeaconListbox`: Enhanced listbox with game-specific features
- `BeaconToolbar`: Custom toolbar implementation
- `SourceList`: macOS-style source list
- `OmniBar`: Command/search interface
- Specialized controls for game data editing

### Data Management

**Blueprint System**: Each supported game implements Blueprint interfaces for:
- Engrams (craftable items)
- Creatures (spawnable entities) 
- Spawn Points (creature spawn configurations)
- Loot Containers (loot drop definitions)

**DataSource Pattern**: Each game has a DataSource class that:
- Manages SQLite database connections
- Provides caching for performance
- Handles blueprint retrieval and searching
- Manages content pack data

**Project System**: Document-based architecture where:
- Each project contains game-specific configurations
- Projects can be saved locally or synchronized to cloud
- Support for templates and presets
- Version control and merging capabilities

### Multi-Game Support

The architecture supports multiple games through:
1. **Game-specific modules** in `Game Support/` folder
2. **Common interfaces** in `Beacon.xojo_code` module
3. **Polymorphic view controllers** that switch based on game type
4. **Game identification system** using string identifiers

### Key Design Patterns

- **Observer Pattern**: NotificationKit for event handling across modules
- **Data Source Pattern**: Centralized data access with caching
- **MVC Architecture**: Clear separation between views, models, and controllers
- **Plugin Architecture**: Support for external content packs and mods
- **Document-based**: Files are first-class objects with versioning support

## Required Dependencies

### Xojo Plugins (MBS 24.0)
The project requires specific MBS plugins for cross-platform functionality:
- Compression, CURL, Encryption
- Platform-specific plugins (Mac64bit, Win, etc.)
- Scintilla for code editing
- RegEx for text processing

Download from: https://www.monkeybreadsoftware.de/xojo/download/plugin/MBS-Xojo-Plugins-plugins240.zip

### External Frameworks
- **Sparkle Framework** (macOS): Automatic updates
- **Jekyll** (docs): Documentation site generation  
- **Node.js/npm** (Website): Frontend build tools
- **PHP/Composer** (Website): Backend API

## Development Notes

- Debug builds automatically run the test suite on startup
- The application uses SQLite databases for game data storage
- Cloud synchronization requires authentication through BeaconAPI
- Cross-platform builds handle platform-specific signing and resource bundling
- The project supports both online and offline modes for development
