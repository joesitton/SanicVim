local ok, impatient = pcall(require, "impatient")

if ok then
    impatient.enable_profile()
end

local modules = require("core.utils").modules

for _, module in ipairs(modules) do
    local ok, err = pcall(require, module)

    if not ok then
        error("Error loading " .. module .. "\n\n" .. err)
    end
end
