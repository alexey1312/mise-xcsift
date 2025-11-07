-- hooks/post_install.lua
-- Performs additional setup after installation
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#postinstall-hook

function PLUGIN:PostInstall(ctx)
    local sdkInfo = ctx.sdkInfo[PLUGIN.name]
    local path = sdkInfo.path

    -- mise automatically extracts the .tar.gz archive
    -- The binary is in the root of the extraction directory
    os.execute("mkdir -p " .. path .. "/bin")

    local srcFile = path .. "/xcsift"
    local destFile = path .. "/bin/xcsift"

    -- Move binary to bin/ and make executable
    local result = os.execute("mv " .. srcFile .. " " .. destFile .. " && chmod +x " .. destFile)
    if result ~= 0 then
        error("Failed to install xcsift binary")
    end

    -- Verify installation works by checking help output
    local testResult = os.execute(destFile .. " --help > /dev/null 2>&1")
    if testResult ~= 0 then
        error("xcsift installation appears to be broken - binary not executable")
    end
end
