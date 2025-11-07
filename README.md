# mise-xcsift

[xcsift](https://github.com/ldomaradzki/xcsift) plugin for [mise](https://mise.jdx.dev/).

## About xcsift

xcsift is a Swift tool that parses xcodebuild output into structured JSON, making it easier for AI coding agents to analyze build results, errors, and warnings.

### Key Features

- **Structured JSON output**: Easy to parse and analyze programmatically
- **Error extraction**: Automatically identifies and formats build errors
- **Warning aggregation**: Groups warnings with optional detailed output
- **Build result summary**: Success/failure status with error counts
- **Test results**: Parses test output when running xcodebuild test

## Installation

### Prerequisites

- macOS (required - xcsift is macOS-only)
- [mise](https://mise.jdx.dev/) installed

### Install Plugin

```bash
mise plugin install xcsift https://github.com/alexey1312/mise-xcsift
```

### Install xcsift

```bash
# Install latest version
mise install xcsift@latest
mise use -g xcsift@latest

# Install specific version
mise install xcsift@1.0.11
mise use -g xcsift@1.0.11
```

## Usage

### Basic Usage

```bash
# Parse xcodebuild output
xcodebuild build -scheme YourScheme 2>&1 | xcsift

# Parse with detailed warnings
xcodebuild build -scheme YourScheme 2>&1 | xcsift --print-warnings

# Parse test results
xcodebuild test -scheme YourScheme -destination "platform=iOS Simulator,id=$SIM_ID" 2>&1 | xcsift
```

### Swift Package Manager

```bash
# Parse swift build output
swift build 2>&1 | xcsift

# Parse swift test output
swift test 2>&1 | xcsift
```

### Important Notes

- **Always use `2>&1`**: This redirects stderr to stdout, ensuring all compiler errors, warnings, and build output are captured
- **Structured output**: xcsift outputs JSON for easy programmatic parsing
- **AI-friendly**: Designed specifically for coding agents to analyze build results

## Configuration

xcsift can be configured in `.tool-versions`:

```
xcsift 1.0.11
```

Or use mise's `.mise.toml`:

```toml
[tools]
xcsift = "1.0.11"
```

## Available Versions

List all available versions:

```bash
mise ls-remote xcsift
```

## Development

### Local Testing

```bash
# Link plugin for development
mise plugin link xcsift /path/to/mise-xcsift

# Test installation
mise install xcsift@latest

# Test functionality
xcodebuild --version 2>&1 | head -1 | xcsift
```

## Related Projects

- [xcsift](https://github.com/ldomaradzki/xcsift) - Original Swift tool
- [mise](https://mise.jdx.dev/) - Development environment manager
- [mise-plugins](https://github.com/mise-plugins) - Community plugins

## Platform Support

- ✅ macOS arm64 (Apple Silicon)
- ✅ macOS x86_64 (Intel) - future releases
- ❌ Linux - not supported (Xcode is macOS-only)
- ❌ Windows - not supported (Xcode is macOS-only)

## Troubleshooting

### Installation fails

```bash
# Enable debug output
MISE_DEBUG=1 mise install xcsift@latest

# Check platform compatibility
uname -sm  # Should show: Darwin arm64 or Darwin x86_64
```

### xcsift not in PATH

```bash
# Verify installation
mise which xcsift

# Reshim if needed
mise reshim
```

### Binary not executable

```bash
# Check binary permissions
ls -la $(mise which xcsift)

# Should show: -rwxr-xr-x
```

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

MIT

## Author

Aleksei Kakoulin

## Acknowledgments

- [ldomaradzki](https://github.com/ldomaradzki) - xcsift author
- [jdx](https://github.com/jdx) - mise creator
