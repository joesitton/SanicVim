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
		build = ':lua require("go.install").update_all_sync()'
	},

	{
		{
			"iamcco/markdown-preview.nvim",
			cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
			build = "cd app && yarn install",
			init = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
			ft = { "markdown" },
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
