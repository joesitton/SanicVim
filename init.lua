local ok, impatient = pcall(require, "impatient")

if ok then
    impatient.enable_profile()
end

local modules = {
    "settings",
    "autocmds",
    "commands",
}

for _, module in ipairs(modules) do
    local ok, err = pcall(require, "core." .. module)

    if not ok then
        error("Error loading " .. module .. "\n\n" .. err)
    end
end

require("plugins")
