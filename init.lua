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

vim.cmd([[
hi! link @function.builtin FuncBuiltin
hi! link @constant.builtin ConstBuiltin
hi! link @field Field
hi! link @property Property
hi! link @variable Variable
hi! link @variable.builtin VariableBuiltin
hi! link @constructor Constructor
hi! link @type.definition TypeDefinition
]])
