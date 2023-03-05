-- Try to load impatient.nvim
local ok, impatient = pcall(require, "impatient")

if ok then
    impatient.enable_profile()
end

-- Load our modules
local modules = {
    "core.settings",
    "core.autocmds",
    "core.commands",
    "plugins",
}

for _, module in ipairs(modules) do
    local ok, err = pcall(require, module)

    if not ok then
        error("Error loading " .. module .. "\n\n" .. err)
    end
end

-- Link some highlights
vim.cmd([[
hi! link @function.builtin FuncBuiltin
hi! link @constant.builtin ConstBuiltin
hi! link @field Field
hi! link @property Property
hi! link @variable Variable
hi! link @variable.builtin VariableBuiltin
hi! link @constructor Constructor
hi! link @type.definition TypeDefinition
hi! link @parameter Parameter
hi! link @include PreProc
]])
