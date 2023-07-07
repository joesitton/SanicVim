return {
	-- {{{ Core
	{
		"nvim-lua/plenary.nvim",
		lazy = false,
	},

	-- {
	-- 	"nvim-lua/popup.nvim",
	-- 	lazy = false,
	-- },

	-- }}}

	-- {{{ Colorschemes

	{
		dir = "~/Dev/lush-base16",
		lazy = false,
		dependencies = { "rktjmp/lush.nvim" },
		config = function()
			vim.cmd("silent! colo lush-base16")
		end,
	},

	-- }}}

	-- {{{ Completion

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
	},

	{
		"hrsh7th/nvim-cmp",
		version = false,
		dependencies = {
			{
				"hrsh7th/cmp-nvim-lsp",
				event = "InsertEnter",
			},
			{
				"hrsh7th/cmp-calc",
				event = "InsertEnter",
			},
			-- {
			-- 	"hrsh7th/cmp-emoji",
			-- 	event = "InsertEnter",
			-- },
			{
				"FelipeLema/cmp-async-path",
				event = { "InsertEnter", "CmdlineEnter" },
			},
			{
				"hrsh7th/cmp-cmdline",
				event = { "InsertEnter", "CmdlineEnter" },
			},
			{
				"hrsh7th/cmp-buffer",
				event = "InsertEnter",
			},
			{
				"amarakon/nvim-cmp-buffer-lines",
				event = "InsertEnter",
			},
			{
				"hrsh7th/cmp-nvim-lua",
				event = "InsertEnter",
			},
			{
				"hrsh7th/cmp-nvim-lsp-document-symbol",
				event = { "InsertEnter", "CmdlineEnter" },
			},
			{
				"hrsh7th/cmp-nvim-lsp-signature-help",
				event = "InsertEnter",
			},
			{
				"joesitton/cmp-rg",
				event = { "InsertEnter", "CmdlineEnter" },
			},
			{
				"zbirenbaum/copilot-cmp",
				dependencies = { "copilot.lua" },
				config = function()
					require("copilot_cmp").setup()
				end,
				event = "InsertEnter",
			},
			-- {
			-- 	"tzachar/cmp-tabnine",
			-- 	build = "./install.sh",
			-- 	event = "InsertEnter",
			-- },
			{
				"ray-x/cmp-treesitter",
				event = "InsertEnter",
			},
			{
				"petertriho/cmp-git",
				ft = "gitcommit",
			},
			{
				"kdheepak/cmp-latex-symbols",
				ft = "tex",
			},
			{
				"L3MON4D3/LuaSnip",
				dependencies = {
					"rafamadriz/friendly-snippets",
				},
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
				event = "InsertEnter",
			},
			{
				"saadparwaiz1/cmp_luasnip",
			},
			{
				"lukas-reineke/cmp-under-comparator",
			},
			{
				"rcarriga/cmp-dap",
				event = "InsertEnter",
			},
		},
		config = function()
			require("plugins.configs.cmp")
		end,
		event = { "InsertEnter", "CmdlineEnter" },
	},

	{
		"abecodes/tabout.nvim",
		config = function()
			require("tabout").setup({ ignore_beginning = false })
		end,
		event = { "InsertEnter" },
	},

	-- }}}

	-- {{{ LSP

	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"jayp0521/mason-null-ls.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"jose-elias-alvarez/null-ls.nvim",
		"b0o/SchemaStore.nvim",
		"folke/neodev.nvim",
		{
			"neovim/nvim-lspconfig",
			config = function()
				require("plugins.configs.lsp")
			end,
			event = "BufReadPost",
		},
	},

	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = function()
			require("plugins.configs.fidget")
		end,
		event = "BufReadPost",
	},

	-- }}}

	-- {{{ Treesitter

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{
				"HiPhish/nvim-ts-rainbow2",
			},
			{
				"andymass/vim-matchup",
				event = "CursorMoved",
			},
			-- {
			--     "nvim-treesitter/nvim-treesitter-context",
			--     config = function() require("treesitter-context").setup({ max_lines = 3 }) end,
			--     event = "WinScrolled",
			-- },
			{
				"windwp/nvim-autopairs",
				opts = {
					check_ts = true,
					enable_check_bracket_line = false,
					disable_filetype = { "TelescopePrompt" },
				},
				event = "InsertEnter",
			},
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				event = "BufReadPost",
			},
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				event = "BufReadPost",
			},
			{
				"nvim-treesitter/playground",
				cmd = "TSPlaygroundToggle",
			},
			{
				"lewis6991/spellsitter.nvim",
				config = function()
					require("spellsitter").setup()
				end,
				event = "BufReadPost",
			},
			{
				"RRethy/nvim-treesitter-textsubjects",
				event = "BufReadPost",
			},
			-- {
			-- 	"ziontee113/syntax-tree-surfer",
			-- 	config = function()
			-- 		require("syntax-tree-surfer").setup()
			-- 	end,
			-- 	event = "BufReadPost",
			-- },
			{
				"m-demare/hlargs.nvim",
				config = function()
					require("plugins.configs.hlargs")
				end,
				event = "BufReadPost",
			},
			-- {
			--     "haringsrob/nvim_context_vt",
			--     config = function() require('nvim_context_vt').setup() end,
			--     event = "BufReadPost"
			-- }
		},
		build = ":silent! TSUpdate",
		config = function()
			require("plugins.configs.treesitter")
		end,
		event = "BufReadPost",
	},

	-- }}}

	-- {{{ Functionality

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},

	{
		"tpope/vim-sleuth",
		event = "BufReadPost",
	},

	-- {
	-- 	"tpope/vim-repeat",
	-- 	event = "VeryLazy",
	-- },

	{
		"tpope/vim-fugitive",
		event = "VimEnter",
	},

	{
		"famiu/bufdelete.nvim",
		cmd = { "Bdelete", "Bwipeout" },
	},

	{
		"fedepujol/move.nvim",
	},

	-- {
	-- 	"chrisgrieser/nvim-spider",
	-- 	lazy = true,
	-- },

	{
		"ggandor/leap.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},

	{
		"ggandor/flit.nvim",
		opts = { labeled_modes = "nx" },
	},

	{
		"goolord/alpha-nvim",
		config = function()
			require("plugins.configs.alpha")
		end,
		event = "VimEnter",
	},

	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("plugins.configs.lastplace")
		end,
		event = "BufReadPost",
	},

	{
		"folke/which-key.nvim",
		config = function()
			require("plugins.configs.whichkey")
		end,
		event = "VimEnter",
	},

	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
		event = "InsertEnter",
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.configs.comments")
		end,
		event = "BufReadPost",
	},

	{
		"LudoPinelli/comment-box.nvim",
		config = function()
			require("comment-box").setup({ line_blank_line_above = true, line_blank_line_below = true })
		end,
		event = "BufReadPost",
	},

	-- {
	-- 	"stevearc/dressing.nvim",
	-- 	config = function()
	-- 		require("plugins.configs.dressing")
	-- 	end,
	-- 	event = "UIEnter",
	-- },

	{
		"MunifTanjim/nui.nvim",
		event = "UIEnter",
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = { "nui.nvim" },
		config = function()
			require("plugins.configs.tree")
		end,
		cmd = { "Neotree" },
	},

	{
		"sindrets/diffview.nvim",
		config = function()
			require("plugins.configs.diffview")
		end,
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	},

	{
		"godlygeek/tabular",
		event = "BufReadPost",
	},

	-- {
	--     "michaelb/sniprun",
	--     build = "bash ./install.sh",
	--     cmd = "SnipRun",
	-- },

	-- {
	--     "nvim-neotest/neotest",
	--     config = function() require("plugins.configs.test") end,
	-- },

	-- {
	--     "pwntester/octo.nvim",
	--     config = function() require("octo").setup() end,
	-- },

	-- {
	-- 	"nvim-neorg/neorg",
	-- 	config = function()
	-- 		require("plugins.configs.neorg")
	-- 	end,
	-- 	ft = "norg",
	-- },

	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
	},

	{
		"AckslD/swenv.nvim",
		config = function()
			require("swenv").setup({ venvs_path = vim.fn.expand("~/.pyenv/versions/") })
		end,
		event = "VimEnter",
	},

	-- }}}

	-- {{{ Telescope

	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.1",
		config = function()
			require("plugins.configs.telescope")
		end,
		event = "VimEnter",
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build =
		"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		config = function()
			require("telescope").load_extension("fzf")
		end,
		event = "VimEnter",
	},

	{
		"gbrlsnchs/telescope-lsp-handlers.nvim",
		config = function()
			require("telescope").load_extension("lsp_handlers")
		end,
		event = "VimEnter",
	},

	{
		"olacin/telescope-gitmoji.nvim",
		config = function()
			require("telescope").load_extension("gitmoji")
		end,
		event = "VimEnter",
	},

	{
		"benfowler/telescope-luasnip.nvim",
		config = function()
			require("telescope").load_extension("luasnip")
		end,
		event = "VimEnter",
	},

	-- {
	-- 	"ahmedkhalf/project.nvim",
	-- 	config = function()
	-- 		require("project_nvim").setup({ exclude_dirs = { "~/.local/*" }, silent_chdir = true, scope_dir = "win" })
	-- 		require("telescope").load_extension("projects")
	-- 	end,
	-- 	event = "VimEnter",
	-- },

	{
		"AckslD/nvim-neoclip.lua",
		dependencies = "kkharji/sqlite.lua",
		config = function()
			require("plugins.configs.neoclip")
			require("telescope").load_extension("neoclip")
		end,
		event = "VimEnter",
	},

	{
		"ThePrimeagen/harpoon",
		config = function()
			require("harpoon").setup({})
			require("telescope").load_extension("harpoon")
		end,
		event = "VimEnter",
	},

	{
		"stevearc/aerial.nvim",
		config = function()
			require("plugins.configs.aerial")
			require("telescope").load_extension("aerial")
		end,
		event = "VimEnter",
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 3000,
			background_colour = "#181818",
			render = "minimal",
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		config = function(_, opts)
			require("notify").setup(opts)
			require("telescope").load_extension("notify")
		end,
		event = "VeryLazy",
	},

	-- {
	--     "ThePrimeagen/refactoring.nvim",
	--     config = function()
	--         require("refactoring").setup()
	--         require("telescope").load_extension("refactoring")
	--      end,
	-- },

	{
		"olimorris/persisted.nvim",
		config = function()
			require("plugins.configs.session")
			require("telescope").load_extension("persisted")
		end,
		event = "VimEnter",
	},

	{
		"debugloop/telescope-undo.nvim",
		config = function()
			require("telescope").load_extension("undo")
		end,
		event = "VimEnter",
	},

	-- {
	-- 	"folke/noice.nvim",
	-- 	opts = {
	-- 		lsp = {
	-- 			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	-- 			override = {
	-- 				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 				["vim.lsp.util.stylize_markdown"] = true,
	-- 				["cmp.entry.get_documentation"] = true,
	-- 			},
	-- 			progress = {
	-- 				enabled = false,
	-- 			},
	-- 		},
	-- 		cmdline = {
	-- 			enabled = false,
	-- 			view = "cmdline",
	-- 		},
	-- 		messages = {
	-- 			enabled = false,
	-- 		},
	-- 		popupmenu = {
	-- 			backend = "cmp",
	-- 			kind_icons = require("core.utils").symbols,
	-- 		},
	-- 		presets = {
	-- 			bottom_search = false, -- use a classic bottom cmdline for search
	-- 			command_palette = false, -- position the cmdline and popupmenu together
	-- 			long_message_to_split = true, -- long messages will be sent to a split
	-- 			inc_rename = true, -- enables an input dialog for inc-rename.nvim
	-- 			lsp_doc_border = false, -- add a border to hover docs and signature help
	-- 		},
	-- 	},
	-- 	event = "VeryLazy",
	-- },

	-- }}}

	-- {{{ Appearance

	{
		"nvim-tree/nvim-web-devicons",
		event = "VimEnter",
	},

	{
		"romgrk/barbar.nvim",
		version = "^1.0.0",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"lewis6991/gitsigns.nvim",
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		config = function()
			require("plugins.configs.barbar")
		end,
		event = "VimEnter",
	},

	-- {
	-- 	"b0o/incline.nvim",
	-- 	config = function()
	-- 		require("plugins.configs.incline")
	-- 	end,
	-- 	event = "BufReadPost"
	-- },

	{
		"utilyre/barbecue.nvim",
		dependencies = {
			"smiteshp/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			create_autocmd = false,
			attach_navic = false,
			context_follow_icon_color = true,
			show_dirname = true,
			show_basename = true,
			kinds = require("core.utils").symbols,
			theme = {
				normal = { bg = "#212121" },
			},
		},
		event = "VeryLazy",
	},

	{
		"rebelot/heirline.nvim",
		config = function()
			require("plugins.configs.heirline")
		end,
		event = "VeryLazy",
	},

	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	config = function ()
	-- 		require("plugins.configs.statusline")
	-- 	end,
	-- 	event = "VeryLazy"
	-- },

	{
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup()
		end,
	},

	{
		"chentoast/marks.nvim",
		config = function()
			require("plugins.configs.marks")
		end,
		event = "BufReadPost",
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("plugins.configs.colorizer")
		end,
		event = "BufReadPost",
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("plugins.configs.indentline")
		end,
		event = "BufReadPost",
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.configs.gitsigns")
		end,
		event = "BufReadPost",
	},

	{
		"karb94/neoscroll.nvim",
		config = function()
			require("plugins.configs.neoscroll")
		end,
		event = "WinScrolled",
	},

	{
		"RRethy/vim-illuminate",
		config = function()
			require("plugins.configs.illuminate")
		end,
		event = "BufReadPost",
	},

	-- {
	-- 	"beauwilliams/focus.nvim",
	-- 	config = function()
	-- 		require("plugins.configs.focus")
	-- 	end,
	-- 	cmd = "FocusEnable",
	-- },

	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			require("plugins.configs.ufo")
		end,
		event = "BufReadPost",
	},

	{
		"folke/zen-mode.nvim",
		config = function()
			require("plugins.configs.zenmode")
		end,
		cmd = "ZenMode",
	},

	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("plugins.configs.term")
		end,
		event = "VeryLazy",
	},

	-- {
	-- 	"petertriho/nvim-scrollbar",
	-- 	config = function()
	-- 		require("plugins.configs.scrollbar")
	-- 	end,
	-- 	event = "BufReadPost",
	-- },

	-- {
	-- 	"xiyaowong/virtcolumn.nvim",
	-- 	config = function()
	-- 		vim.g.virtcolumn_char = "▕"
	-- 	end,
	-- },

	-- {
	-- 	"m4xshen/smartcolumn.nvim",
	-- 	config = function()
	-- 		require("smartcolumn").setup({
	-- 			colorcolumn = "80",
	-- 			disabled_filetypes = { "help", "test", "markdown", "lazy", "alpha" },
	-- 		})
	-- 	end,
	-- },

	-- {
	-- 	"gen740/SmoothCursor.nvim",
	-- 	config = function()
	-- 		require("smoothcursor").setup({ disabled_filetypes = { "lazy", "help" }, disable_float_win = true })
	-- 	end,
	-- },

	-- {
	-- 	"anuvyklack/windows.nvim",
	-- 	dependencies = {
	-- 		"anuvyklack/middleclass",
	-- 		"anuvyklack/animation.nvim",
	-- 	},
	-- 	config = function()
	-- 		vim.o.winwidth = 10
	-- 		vim.o.winminwidth = 10
	-- 		vim.o.equalalways = false
	-- 		require("windows").setup({ autowidth = { enabled = false, minwidth = 0.2 } })
	-- 	end,
	-- 	event = "VeryLazy",
	-- },

	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("plugins.configs.hlslens")
		end,
		keys = { "/", "?", "*", "#", "n", "N" },
	},

	{
		"amrbashir/nvim-docs-view",
		config = function()
			require("docs-view").setup({ position = "bottom" })
		end,
		cmd = { "DocsViewToggle" },
	},

	-- }}}
}
