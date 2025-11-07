-- hooks/pre_install.lua
-- Returns download information for a specific version
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#preinstall-hook

-- Helper function for platform detection
local function get_platform()
    -- RUNTIME object is provided by mise/vfox
    -- RUNTIME.osType: "Windows", "Linux", "Darwin"
    -- RUNTIME.archType: "amd64", "386", "arm64", etc.

    local os_name = RUNTIME.osType:lower()
    local arch = RUNTIME.archType

    -- xcsift currently only supports macOS
    -- Format: macos-arm64, macos-x86_64 (future)
    local platform_map = {
        ["darwin"] = {
            ["arm64"] = "macos-arm64",
            ["amd64"] = "macos-x86_64",
        },
    }

    local os_map = platform_map[os_name]
    if os_map and os_map[arch] then
        return os_map[arch]
    end

    -- xcsift is macOS-only, error on other platforms
    error("xcsift is only available for macOS. Current platform: " .. os_name .. "-" .. arch)
end

function PLUGIN:PreInstall(ctx)
    local version = ctx.version
    local platform = get_platform()

    -- xcsift release naming: xcsift-v{version}-{platform}.tar.gz
    -- Example: https://github.com/ldomaradzki/xcsift/releases/download/v1.0.11/xcsift-v1.0.11-macos-arm64.tar.gz
    local url = "https://github.com/ldomaradzki/xcsift/releases/download/v" .. version .. "/xcsift-v" .. version .. "-" .. platform .. ".tar.gz"

    return {
        version = version,
        url = url,
        note = "Downloading xcsift " .. version .. " for " .. platform,
    }
end
