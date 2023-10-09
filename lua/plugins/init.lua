-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
local ok, lazy = pcall(require, "lazy")
if not ok then
	vim.notify("Error loading lazy.nvim: " .. lazy, vim.log.levels.ERROR)
	return
end

lazy.setup({
	spec = {
		{ import = "plugins.specs.default" },
		{ import = "plugins.specs.filetypes" },
		{ import = "plugins.specs.dap" },
	},
	concurrency = 12,
	defaults = {
		lazy = false,
		version = false,
	},
	-- checker = { enabled = true },
	ui = {
		size = { width = 0.7, height = 0.7 },
		border = "rounded",
		icons = {
			lazy = "💤 ",
		},
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"gzip",
				"zip",
				"zipPlugin",
				"tar",
				"tarPlugin",
				"getscript",
				"getscriptPlugin",
				"vimball",
				"vimballPlugin",
				"2html_plugin",
				"logipat",
				"rrhelper",
				"spellfile_plugin",
				"matchit",
			},
		},
	},
})
