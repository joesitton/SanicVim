local default_plugins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(default_plugins) do
    vim.g["loaded_" .. plugin] = 1
end

pcall(vim.cmd, "packadd packer.nvim")

local ok, packer = pcall(require, "plugins.packer_init")

if not ok then
    error("Could not load packer\n" .. packer)
end

local plugins = require("plugins.plugins")

return packer.startup({
    function(use)
        for _, plugin in ipairs(plugins) do
            use(plugin)
        end
    end,
})
