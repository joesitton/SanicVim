local ok, impatient = pcall(require, "impatient")

if ok then
    impatient.enable_profile()
end

local modules = {
    "core.settings",
    "core.autocmds",
    "core.commands",
    "plugins",
}

for _, module in ipairs(modules) do
    ---@diagnostic disable-next-line: lowercase-global
    ok, err = pcall(require, module)

    if not ok then
        error("Error loading " .. module .. "\n\n" .. err)
    end
end
