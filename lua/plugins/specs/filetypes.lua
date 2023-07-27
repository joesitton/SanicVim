return {
	{
		"lervag/vimtex",
		ft = "tex",
	},

	{
		"zeek/vim-zeek",
		ft = "zeek",
	},

	{
		"s3rvac/vim-syntax-yara",
		config = function()
			vim.cmd("autocmd BufNewFile,BufRead *.yara setlocal filetype=yara")
		end,
		ft = "yara",
	},

	{
		"euclidianAce/BetterLua.vim",
		ft = "lua",
	},

	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
		},
		opts = {
			lsp_gofumpt = true,
			-- lsp_on_attach = nil,
			lsp_keymaps = false,
			lsp_codelens = false,
		},
		ft = { "go", "gomod" },
		event = "CmdlineEnter",
		build = ":lua require('go.install').update_all_sync()",
	},

	{
		"ellisonleao/glow.nvim",
		config = function()
			vim.g.glow_border = "rounded"
		end,
		ft = "markdown",
	},

	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_auto_start = 1
		end,
		ft = "markdown",
	},

	{
		"baskerville/vim-sxhkdrc",
		ft = "sxhkdrc",
	},

	{
		"towolf/vim-helm",
		config = function()
			vim.cmd("autocmd BufNewFile,BufRead *.{yaml,yml}.template setlocal filetype=helm")
		end,
		ft = "helm",
	},
}
