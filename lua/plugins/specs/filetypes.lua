return {
	{
		"euclidianAce/BetterLua.vim",
		ft = "lua",
	},

	{
		"ray-x/go.nvim",
		opts = {},
		event = "CmdlineEnter",
		ft = { "go", "gomod" },
	},

	{
		{
			"iamcco/markdown-preview.nvim",
			build = "cd app && npm install",
			config = function()
				vim.g.mkdp_auto_start = 1
			end,
		},
		{
			"ellisonleao/glow.nvim",
			config = function()
				vim.g.glow_border = "rounded"
			end,
		},
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
		ft = "yara",
	},
}
