-- metadata.lua
-- Plugin metadata and configuration
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#metadata-lua

PLUGIN = { -- luacheck: ignore
    -- Required: Tool name (lowercase, no spaces)
    name = "xcsift",

    -- Required: Plugin version (not the tool version)
    version = "1.0.0",

    -- Required: Brief description of the tool
    description = "Swift tool to parse xcodebuild output for coding agents",

    -- Required: Plugin author/maintainer
    author = "Aleksei Kakoulin",

    -- Optional: Repository URL for plugin updates
    updateUrl = "https://github.com/alexey1312/mise-xcsift",

    -- Optional: Minimum mise runtime version required
    minRuntimeVersion = "0.2.0",
}
