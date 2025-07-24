# Development Documentation

## Technical Details

**Namespace:** `rgpvpwvpumc`
- `rg`: RagedUnicorn (developer prefix)
- `pvpw`: PVPWarn (main addon)
- `vp`: Voice Pack
- `umc`: Undead Male Classic

### Code Structure

The voice pack follows a modular structure:

- `Core.lua` - Main initialization and registration with PVPWarn
- `Constants.lua` - Addon constants and configuration values
- `Environment.lua` - Environment-specific settings
- `Logger.lua` - Logging utilities
- `Frame.xml` - UI frame definitions

### Integration with PVPWarn

The voice pack registers itself with the main PVPWarn addon using:

```lua
rgpvpw.addon.RegisterVoicePack(
    RGPVPW_VP_UMC_CONSTANTS.ADDON_NAME,
    RGPVPW_VP_UMC_CONSTANTS.DISPLAY_NAME,
    RGPVPW_VP_UMC_CONSTANTS.ASSET_PATH
)
```

### Adding New Voice Files

Voice files should be placed in the appropriate directory structure that mirrors PVPWarn's sound organization:
- `assets/sounds/[category]/[spell_name].mp3`

### Development Workflow

1. Clone the repository
2. Make changes to the code
3. Test in-game with PVPWarn installed
4. Ensure all voice files are properly registered
5. Submit pull request with changes

### Debugging

Debug logging is automatically enabled when using the development profile (which is active by default). The development profile sets the appropriate logging levels in `Environment.lua`.

To ensure debug logging is active:
```bash
# Generate development environment files
mvn generate-resources -D generate.sources.overwrite=true -P development
```

This will generate `Environment.lua` with debug logging enabled. You can also manually adjust logging levels in `Environment.lua` if needed.

### Building for Release

1. Ensure all development files are removed
2. Verify all voice files are included
3. Update version in `.toc` file
4. Create release package

## Build System

This project uses Maven for build automation and deployment. The build system handles environment switching, packaging, and deployment to various addon platforms.

### Maven Profiles

The project includes several Maven profiles for different purposes:

#### Development Profile (default)
```bash
mvn clean package
```
- Includes debug logging and development files
- Generates development-specific environment files
- Package includes `development` suffix

#### Release Profile
```bash
mvn clean package -P release
```
- Optimized for production use
- Excludes development files
- Minimal logging

#### Deployment Profiles

**GitHub Release:**
```bash
mvn package -P deploy-github -D github.auth-token=[token]
```

**CurseForge Release:**
```bash
mvn package -P deploy-curseforge -D curseforge.auth-token=[token]
```
- Note: Update `addon.curseforge.projectId` in pom.xml before deploying

**Wago.io Release:**
```bash
mvn package -P deploy-wago -D wago.auth-token=[token]
```
- Note: Update `addon.wago.projectId` in pom.xml before deploying

### Environment Switching

The build system can generate environment-specific files:

```bash
# Switch to development
mvn generate-resources -D generate.sources.overwrite=true -P development

# Switch to release
mvn generate-resources -D generate.sources.overwrite=true -P release
```

This will generate/update:
- `PVPWarn_VoicePack_UMC.toc` (from templates)
- `code/Environment.lua` (from environment.lua.tpl)

**Important:** Always commit files in development state. The repository should maintain development configuration by default.

### Build Resources

The `build-resources/` directory contains:
- `addon-development.properties` - Development environment variables
- `addon-release.properties` - Release environment variables
- `assembly-*.xml` - Package assembly descriptors
- `*.tpl` - Template files for environment-specific generation
- `release-notes.md` - Release notes for deployments

### Creating a New Release

1. Update version in `pom.xml`
2. Update release notes in `build-resources/release-notes.md`
3. Switch to release environment:
   ```bash
   mvn generate-resources -D generate.sources.overwrite=true -P release
   ```
4. Package the addon:
   ```bash
   mvn clean package -P release
   ```
5. Deploy to platforms as needed (see deployment profiles above)
6. Switch back to development:
   ```bash
   mvn generate-resources -D generate.sources.overwrite=true -P development
   ```

### Continuous Integration

The project supports GitHub Actions for automated builds and deployments. See `.github/workflows/` for CI configuration.

## Dependency Management

This repository uses [Renovate](https://docs.renovatebot.com/) for automated dependency updates. Renovate monitors the following:

- **Maven plugins** - Automatically creates PRs for Maven plugin updates
- **GitHub Actions** - Updates workflow action versions
- **WoW version data** - Tracks World of Warcraft Classic Era interface versions, patch versions, and game versions

### Renovate Configuration

The Renovate configuration (`renovate.json`) includes:

- **Schedule**: Runs weekly on Mondays
- **Custom datasources**: Fetches WoW version data from [RagedUnicorn/wow-renovate-data](https://github.com/RagedUnicorn/wow-renovate-data)
- **Auto-merge**: Enabled for development dependencies
- **Grouping**: Groups related updates (Maven plugins, GitHub Actions, WoW versions)

## Testing

### GitHub Pages Tests

The project includes Playwright tests to verify the GitHub Pages deployment is working correctly.

#### Running Tests Locally

```bash
# Install dependencies
npm install

# Run tests against local server
npm test

# Run tests against GitHub Pages (Linux/Mac)
GITHUB_PAGES_URL=https://ragedunicorn.github.io/wow-classic-pvpwarn-vpumc/ npm test

# Run tests against GitHub Pages (Windows Command Prompt)
set GITHUB_PAGES_URL=https://ragedunicorn.github.io/wow-classic-pvpwarn-vpumc/ && npm test

# Run tests against GitHub Pages (Windows PowerShell)
$env:GITHUB_PAGES_URL="https://ragedunicorn.github.io/wow-classic-pvpwarn-vpumc/"; npm test
```

#### Available Tests

- **Main page loading** - Verifies the page loads with correct title
- **Navigation buttons** - Tests class selection buttons functionality  
- **Audio players** - Ensures audio elements are properly loaded
- **Audio file links** - Validates that audio files are accessible
- **Section navigation** - Tests switching between different class sections

#### GitHub Actions Integration

Tests run automatically after GitHub Pages deployment:

1. `build_github_pages.yml` - Builds and deploys the GitHub Pages site
2. `test_github_pages.yml` - Runs Playwright tests when deployment completes (triggered by `deployment_status` event)
