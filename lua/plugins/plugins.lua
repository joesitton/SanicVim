local plugins = {
	-- {{{ Core
	{
		"lewis6991/impatient.nvim",
		lazy = false,
		config = function()
			require("impatient")
		end,
	},

	{
		"nvim-lua/plenary.nvim",
		lazy = false,
	},

	{
		"nvim-lua/popup.nvim",
		lazy = false,
	},

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

	-- {{{ Filetype Support

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
		config = function()
			vim.cmd("autocmd BufNewFile,BufRead *.{yaml,yml}.template setlocal filetype=helm")
		end,
		ft = "helm",
	},

	-- }}}

	-- {{{ Completion

	{
		"hrsh7th/nvim-cmp",
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
			--     "hrsh7th/cmp-emoji",
			--     event = "InsertEnter",
			-- },
			{
				"hrsh7th/cmp-path",
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
				"tzachar/cmp-tabnine",
				build = "./install.sh",
				event = "InsertEnter",
			},
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
				"lukas-reineke/cmp-under-comparator",
			},
			{
				"L3MON4D3/LuaSnip",
				dependencies = {
					{
						"rafamadriz/friendly-snippets",
					},
				},
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
				event = "InsertEnter",
			},
			{
				"saadparwaiz1/cmp_luasnip",
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
			require("tabout").setup({ act_as_tab = true })
		end,
	},

	-- }}}

	-- {{{ LSP

	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"jayp0521/mason-null-ls.nvim",
		"jose-elias-alvarez/null-ls.nvim",
		"b0o/SchemaStore.nvim",
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
				"p00f/nvim-ts-rainbow",
				event = "BufReadPost",
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
				config = function()
					require("plugins.configs.autopairs")
				end,
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
			{
				"ziontee113/syntax-tree-surfer",
				config = function()
					require("syntax-tree-surfer").setup()
				end,
				event = "BufReadPost",
			},
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
		"tpope/vim-surround",
		event = "BufReadPost",
	},

	{
		"tpope/vim-sleuth",
		event = "BufReadPost",
	},

	{
		"tpope/vim-repeat",
		event = "BufReadPost",
	},

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
		"jghauser/mkdir.nvim",
		config = function()
			require("mkdir")
		end,
		event = "BufWritePre",
	},

	{
		"folke/which-key.nvim",
		config = function()
			require("plugins.configs.whichkey")
		end,
		event = "VimEnter",
	},

	-- {
	--     "ziontee113/icon-picker.nvim",
	--     config = function() require("icon-picker") end,
	--     cmd = { "PickEverything", "PickEverythingInsert" },
	-- },

	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup({ teasing = false })
		end,
		event = "BufReadPost",
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
		dependencies = {
			"s1n7ax/nvim-comment-frame",
			dependencies = "nvim-treesitter",
			event = "BufReadPost",
		},
		config = function()
			require("plugins.configs.comments")
		end,
		event = "BufReadPost",
	},

	{
		"stevearc/dressing.nvim",
		config = function()
			require("plugins.configs.dressing")
		end,
		event = "UIEnter",
	},

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

	{
		"nvim-neorg/neorg",
		config = function()
			require("plugins.configs.neorg")
		end,
		ft = "norg",
	},

	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
		cmd = { "IncRename" },
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
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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

	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({ exclude_dirs = { "~/.local/*" }, silent_chdir = false })
			require("telescope").load_extension("projects")
		end,
		event = "VimEnter",
	},

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
		config = function()
			require("notify").setup({ background_colour = "#181818", render = "minimal" })
			require("telescope").load_extension("notify")
		end,
		event = "VimEnter",
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

	-- {
	-- 	"folke/noice.nvim",
	-- 	config = function()
	-- 		require("plugins.configs.noice")
	-- 		require("telescope").load_extension("noice")
	-- 	end,
	-- 	event = "VimEnter",
	-- },

	-- }}}

	-- {{{ Appearance

	{
		"kyazdani42/nvim-web-devicons",
		event = "VimEnter",
	},

	{
		"romgrk/barbar.nvim",
		config = function()
			require("plugins.configs.barbar")
		end,
		event = "VimEnter",
	},

	-- {
	--     "nanozuki/tabby.nvim",
	--     config = function() require("plugins.configs.tabby") end,
	--     event = "VimEnter",
	-- },

	{
		"utilyre/barbecue.nvim",
		dependencies = {
			"nvim-lspconfig",
			"smiteshp/nvim-navic",
		},
		config = function()
			require("barbecue").setup({ create_autocmd = false, kinds = require("core.utils").symbols })
		end,
	},

	{
		"feline-nvim/feline.nvim",
		config = function()
			require("plugins.configs.feline")
		end,
		event = "VimEnter",
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

	{
		"beauwilliams/focus.nvim",
		config = function()
			require("plugins.configs.focus")
		end,
		cmd = "FocusEnable",
	},

	{
		"luukvbaal/stabilize.nvim",
		config = function()
			require("stabilize").setup()
		end,
		event = "BufReadPost",
	},

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
		version = "v1.*",
		config = function()
			require("plugins.configs.term")
		end,
	},

	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("plugins.configs.scrollbar")
		end,
		event = "BufReadPost",
	},

	{
		"xiyaowong/virtcolumn.nvim",
		config = function()
			vim.g.virtcolumn_char = "▕"
		end,
	},

	-- {
	-- 	"m4xshen/smartcolumn.nvim",
	-- 	config = function()
	-- 		require("smartcolumn").setup({
	-- 			colorcolumn = "80",
	-- 			disabled_filetypes = { "help", "test", "markdown", "lazy", "alpha" },
	-- 		})
	-- 	end,
	-- },

	{
		"gen740/SmoothCursor.nvim",
		config = function()
			require("smoothcursor").setup({ disabled_filetypes = { "lazy", "help" }, disable_float_win = true })
		end,
	},

	{
		"anuvyklack/windows.nvim",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false
			require("windows").setup()
		end,
	},

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

return plugins
