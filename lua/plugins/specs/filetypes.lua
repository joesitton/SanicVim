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
		"fatih/vim-go",
		ft = "go",
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
		ft = "helm",
	},
}
