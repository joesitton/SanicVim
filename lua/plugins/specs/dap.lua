return {
	--  ╭──────────────────────────────────────────────────────────╮
	--  │ DAP                                                      │
	--  ╰──────────────────────────────────────────────────────────╯

	{
		"rcarriga/nvim-dap-ui",
		event = "VimEnter",
	},

	{
		"Weissle/persistent-breakpoints.nvim",
		config = function()
			require("persistent-breakpoints").setup({
				load_breakpoints_event = { "BufReadPost" },
			})
		end,
	},

	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			config = function()
				require("dap-go").setup()
			end,
		},
		config = function()
			require("plugins.configs.dap")
		end,
		event = "VimEnter",
	},
}
