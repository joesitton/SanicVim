-- Load settings, autocmds, and custom commands
require("core.settings")
require("core.autocmds")
require("core.commands")

-- Load plugins
require("plugins")

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
hi! link illuminatedWord IlluminatedWordText
]])
