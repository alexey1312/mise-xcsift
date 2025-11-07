-- hooks/available.lua
-- Returns a list of available versions for the tool
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#available-hook

function PLUGIN:Available(ctx)
    local http = require("http")
    local json = require("json")

    -- xcsift uses GitHub tags for versioning
    local repo_url = "https://api.github.com/repos/ldomaradzki/xcsift/tags"

    -- Use GITHUB_TOKEN if available to avoid rate limits
    local headers = {}
    local github_token = os.getenv("GITHUB_TOKEN")
    if github_token and github_token ~= "" then
        headers["Authorization"] = "Bearer " .. github_token
    end

    local resp, err = http.get({
        url = repo_url,
        headers = headers,
    })

    if err ~= nil then
        error("Failed to fetch versions: " .. err)
    end
    if resp.status_code ~= 200 then
        error("GitHub API returned status " .. resp.status_code .. ": " .. resp.body)
    end

    local tags = json.decode(resp.body)
    local result = {}

    -- Process tags and clean up version strings
    for _, tag_info in ipairs(tags) do
        local version = tag_info.name

        -- Remove 'v' prefix if present (v1.0.11 -> 1.0.11)
        version = version:gsub("^v", "")

        table.insert(result, {
            version = version,
            note = nil,
        })
    end

    return result
end
