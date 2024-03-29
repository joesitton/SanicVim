return {
	--  ╭──────────────────────────────────────────────────────────╮
	--  │ Core                                                     │
	--  ╰──────────────────────────────────────────────────────────╯

	{
		"nvim-lua/plenary.nvim",
		lazy = false,
	},

	-- {,
	--  "nvim-lua/popup.nvim",
	--  lazy = false,
	-- },

	{
		dir = "~/Dev/lush-base16",
		lazy = false,
		dependencies = "rktjmp/lush.nvim",
		config = function()
			vim.cmd("silent! colo lush-base16")
		end,
	},

	{
		"folke/which-key.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("plugins.configs.whichkey")
		end,
		event = "VimEnter",
	},

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ LSP                                                      │
	--  ╰──────────────────────────────────────────────────────────╯

	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"b0o/SchemaStore.nvim",
		"hinell/lsp-timeout.nvim",
		{
			"neovim/nvim-lspconfig",
			config = function()
				require("plugins.configs.lsp")
			end,
		},
		event = "VeryLazy",
	},

	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = function()
			require("plugins.configs.fidget")
		end,
		event = "LspAttach",
	},

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ Formatting                                               │
	--  ╰──────────────────────────────────────────────────────────╯

	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				go = { "gofumpt", "goimports", "goimports-reviser" },
				bash = { "shfmt" },
				json = { "fixjson", "jq" },
				-- yaml = { "yamlfmt" },
				-- ["*"] = { "codespell" },
				["_"] = { "trim_whitespace" },
			},
			-- format_on_save = {
			-- 	lsp_fallback = true,
			-- 	timeout_ms = 500,
			-- },
			format_after_save = {
				lsp_fallback = true,
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
		end,
		event = "BufReadPost",
	},

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ Linting                                                  │
	--  ╰──────────────────────────────────────────────────────────╯

	-- {
	-- 	"mfussenegger/nvim-lint",
	-- 	config = function()
	-- 		local linters = {
	-- 			go = { "golangcilint" },
	-- 			python = {},
	-- 			lua = {},
	-- 		}
	-- 		-- for ft, _ in pairs(linters) do
	-- 		-- 	table.insert(linters[ft], "codespell")
	-- 		-- end
	-- 		require("lint").linters_by_ft = linters
	-- 	end,
	-- 	event = { "VimEnter" },
	-- },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ Completion                                               │
	--  ╰──────────────────────────────────────────────────────────╯

	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	build = ":Copilot auth",
	-- 	opts = {
	-- 		suggestion = { enabled = false },
	-- 		panel = { enabled = false },
	-- 	},
	-- 	event = { "BufReadPost", "LspAttach" }
	-- },

	{
		"Exafunction/codeium.nvim",
		opts = {},
		event = "BufEnter",
	},

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
			--  "hrsh7th/cmp-emoji",
			--  event = "InsertEnter",
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
				"lukas-reineke/cmp-rg",
				event = { "InsertEnter", "CmdlineEnter" },
			},
			-- {
			-- 	"zbirenbaum/copilot-cmp",
			-- 	dependencies = "copilot.lua",
			-- 	opts = {},
			-- 	event = { "InsertEnter", "LspAttach" },
			-- },
			-- {
			--  "tzachar/cmp-tabnine",
			--  build = "./install.sh",
			--  event = "InsertEnter",
			-- },
			{
				"ray-x/cmp-treesitter",
				event = "InsertEnter",
			},
			{
				"petertriho/cmp-git",
				opts = {},
				ft = "gitcommit",
			},
			{
				"kdheepak/cmp-latex-symbols",
				ft = "tex",
			},
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
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
			-- {
			--  "rcarriga/cmp-dap",
			--  event = "InsertEnter",
			-- },
		},
		config = function()
			require("plugins.configs.cmp")
		end,
		event = { "InsertEnter", "CmdlineEnter" },
	},

	{
		"abecodes/tabout.nvim",
		opts = {
			ignore_beginning = false,
		},
		event = "InsertEnter",
		after = "nvim-cmp",
	},

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ Treesitter                                               │
	--  ╰──────────────────────────────────────────────────────────╯

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{
				"HiPhish/rainbow-delimiters.nvim",
				config = function()
					local rainbow_delimiters = require("rainbow-delimiters")
					vim.g.rainbow_delimiters = {
						highlight = {
							"rainbowcol1",
							"rainbowcol7",
							"rainbowcol2",
							"rainbowcol6",
							"rainbowcol3",
							"rainbowcol5",
							"rainbowcol4",
						},
					}
				end,
			},
			{
				"andymass/vim-matchup",
				event = "CursorMoved",
			},
			-- {
			-- 	"nvim-treesitter/nvim-treesitter-context",
			-- 	config = function() require("treesitter-context").setup({ max_lines = 3 }) end,
			-- 	event = "WinScrolled",
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
			-- {
			--  "lewis6991/spellsitter.nvim",
			--  opts = {},
			--  event = "BufReadPost",
			-- },
			{
				"RRethy/nvim-treesitter-textsubjects",
				event = "BufReadPost",
			},
			-- {
			--  "ziontee113/syntax-tree-surfer",
			--  config = function()
			--      require("syntax-tree-surfer").setup()
			--  end,
			--  event = "BufReadPost",
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

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ Functionality                                            │
	--  ╰──────────────────────────────────────────────────────────╯

	{
		"kylechui/nvim-surround",
		version = "*",
		opts = {},
		event = "VeryLazy",
	},

	{
		"tpope/vim-sleuth",
		event = "BufReadPost",
	},

	{
		"tpope/vim-fugitive",
		event = "VimEnter",
	},

	-- {
	-- 	"famiu/bufdelete.nvim",
	-- 	cmd = { "Bdelete", "Bwipeout" },
	-- },

	-- {
	--  "fedepujol/move.nvim",
	-- },

	{
		"folke/flash.nvim",
		opts = {
			prompt = { enabled = false },
			jump = { autojump = true },
			modes = {
				search = { enabled = false },
				char = { jump_labels = true },
			},
		},
		event = "VeryLazy",
	},

	{
		"goolord/alpha-nvim",
		config = function()
			require("plugins.configs.alpha")
		end,
		event = "VimEnter",
	},

	-- {
	--  "luukvbaal/statuscol.nvim",
	--  opts = {},
	--  event = "VimEnter",
	-- },

	{
		"ethanholz/nvim-lastplace",
		opts = {
			lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
			lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
			lastplace_open_folds = true,
		},
		event = "BufReadPost",
	},

	{
		"max397574/better-escape.nvim",
		opts = {},
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
		opts = {
			line_blank_line_above = true,
			line_blank_line_below = true,
		},
		event = "BufReadPost",
	},

	-- {
	--  "stevearc/dressing.nvim",
	--  config = function()
	--      require("plugins.configs.dressing")
	--  end,
	--  event = "UIEnter",
	-- },

	{
		"MunifTanjim/nui.nvim",
		event = "UIEnter",
	},

	{
		"nvim-tree/nvim-tree.lua",
		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
		opts = {
			view = { width = 34 },
			renderer = {
				-- root_folder_label = false,
				add_trailing = true,
				group_empty = true,
				highlight_git = true,
				indent_markers = { enable = true },
				icons = {
					git_placement = "before",
					glyphs = { git = { unstaged = "!", untracked = "?", deleted = "✘" } },
				},
			},
			sync_root_with_cwd = false,
			reload_on_bufenter = true,
			respect_buf_cwd = true,
			update_focused_file = { enable = true, update_root = false },
			filters = { dotfiles = true },
			git = { show_on_dirs = true, show_on_open_dirs = false },
			modified = { enable = true, show_on_dirs = true, show_on_open_dirs = false },
			diagnostics = { enable = true, show_on_dirs = true, show_on_open_dirs = false },
		},
		event = "VimEnter",
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
		event = "VeryLazy",
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
	--  "nvim-neorg/neorg",
	--  config = function()
	--      require("plugins.configs.neorg")
	--  end,
	--  ft = "norg",
	-- },

	-- {
	--  "AckslD/swenv.nvim",
	--  opts = {
	--      venvs_path = vim.fn.expand("~/.pyenv/versions/"),
	--  },
	--  event = "VimEnter",
	-- },

	{
		"Wansmer/treesj",
		opts = {
			use_default_keymaps = false,
		},
		event = "InsertEnter",
	},

	-- {
	--  "danymat/neogen",
	--  opts = {
	--      snippet_engine = "luasnip"
	--  },
	--  event = "BufReadPost"
	-- },

	-- {
	--  "gorbit99/codewindow.nvim",
	--  opts = {
	--      window_border = "rounded",
	--      screen_bounds = "background",
	--      show_cursor = false,
	--      use_git = true,
	--  },
	--  event = "BufReadPost",
	-- },

	-- {
	-- 	"dnlhc/glance.nvim",
	-- 	opts = {},
	-- },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ Telescope                                                │
	--  ╰──────────────────────────────────────────────────────────╯

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		-- branch = "0.1.x",
		config = function()
			require("plugins.configs.telescope")
		end,
		event = "VimEnter",
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		after = "telescope.nvim",
		event = "VimEnter",
	},

	{
		"gbrlsnchs/telescope-lsp-handlers.nvim",
		after = "telescope.nvim",
		event = "VimEnter",
	},

	-- {
	--  "olacin/telescope-gitmoji.nvim",
	--  config = function()
	--      require("telescope").load_extension("gitmoji")
	--  end,
	--  event = "VimEnter",
	-- },

	{
		"joesitton/telescope-cc.nvim",
		after = "telescope.nvim",
		event = "VeryLazy",
	},

	{
		"benfowler/telescope-luasnip.nvim",
		after = "telescope.nvim",
		event = "VimEnter",
	},

	-- {
	--  "ahmedkhalf/project.nvim",
	--  opts = {
	--      exclude_dirs = { "~/.local/*" },
	--  },
	--  config = function(_, opts)
	--      require("project_nvim").setup(opts)
	--      require("telescope").load_extension("projects")
	--  end,
	--  event = "VimEnter",
	-- },

	{
		"AckslD/nvim-neoclip.lua",
		dependencies = "kkharji/sqlite.lua",
		config = function()
			require("plugins.configs.neoclip")
		end,
		after = "telescope.nvim",
		event = "VimEnter",
	},

	{
		"ThePrimeagen/harpoon",
		opts = {},
		after = "telescope.nvim",
		event = "VimEnter",
	},

	{
		"stevearc/aerial.nvim",
		config = function()
			require("plugins.configs.aerial")
		end,
		after = "telescope.nvim",
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
			local notify = require("notify")
			notify.setup(opts)
			vim.notify = notify
		end,
		after = "telescope.nvim",
		event = "VeryLazy",
	},

	{
		"rmagatti/auto-session",
		opts = {
			auto_session_use_git_branch = true,
			auto_save_enabled = true,
			auto_restore_enabled = false,
			auto_session_enable_last_session = false,
			auto_session_suppress_dirs = { "~/.local/*" },
			pre_save_cmds = { "silent! DiffviewClose" },
			session_lens = {
				load_on_startup = false,
				previewer = false,
			},
		},
		after = "telescope.nvim",
		event = "VimEnter",
	},

	{
		"debugloop/telescope-undo.nvim",
		after = "telescope.nvim",
		event = "VimEnter",
	},

	{
		"folke/todo-comments.nvim",
		opts = {
			signs = false,
		},
		after = "telescope.nvim",
	},

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ UI                                                       │
	--  ╰──────────────────────────────────────────────────────────╯

	-- {
	--  "folke/noice.nvim",
	--  opts = {
	--      lsp = {
	--          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	--          override = {
	--              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	--              ["vim.lsp.util.stylize_markdown"] = true,
	--              ["cmp.entry.get_documentation"] = true,
	--          },
	--          progress = {
	--              enabled = false,
	--          },
	--      },
	--      cmdline = {
	--          enabled = false,
	--          view = "cmdline",
	--      },
	--      messages = {
	--          enabled = false,
	--      },
	--      popupmenu = {
	--          backend = "cmp",
	--          kind_icons = require("core.utils").symbols,
	--      },
	--      presets = {
	--          bottom_search = false, -- use a classic bottom cmdline for search
	--          command_palette = false, -- position the cmdline and popupmenu together
	--          long_message_to_split = true, -- long messages will be sent to a split
	--          inc_rename = true, -- enables an input dialog for inc-rename.nvim
	--          lsp_doc_border = false, -- add a border to hover docs and signature help
	--      },
	--  },
	--  event = "VeryLazy",
	-- },

	{
		"nvim-tree/nvim-web-devicons",
		event = "VimEnter",
	},

	{
		"romgrk/barbar.nvim",
		version = "^1.0.0",
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		config = function()
			require("plugins.configs.barbar")
		end,
		event = "VimEnter",
	},

	-- {
	--  "b0o/incline.nvim",
	--  config = function()
	--      require("plugins.configs.incline")
	--  end,
	--  event = "BufReadPost"
	-- },

	{
		"utilyre/barbecue.nvim",
		version = "*",
		dependencies = "smiteshp/nvim-navic",
		opts = {
			create_autocmd = false,
			attach_navic = false,
			context_follow_icon_color = true,
			show_dirname = true,
			show_basename = true,
			kinds = require("core.symbols"),
			theme = {
				normal = { bg = "#303030" },
			},
		},
		event = "VeryLazy",
	},

	-- {
	--  "Bekaboo/dropbar.nvim",
	--  opts = {}
	-- },

	-- {
	--  "yaocccc/nvim-foldsign",
	--  opts = {
	--      offset = -3,
	--      foldsigns = {
	--          open = "",
	--          close = "",
	--          seps = { "", "" },
	--      },
	--  },
	--  event = "CursorHold",
	-- },

	{
		"rebelot/heirline.nvim",
		config = function()
			require("plugins.configs.heirline")
		end,
		event = "VimEnter",
	},

	{
		"folke/zen-mode.nvim",
		dependencies = {
			{
				"folke/twilight.nvim",
				opts = {
					context = 30,
				},
				event = "VeryLazy",
			},
		},
		config = function()
			require("plugins.configs.zenmode")
		end,
		cmd = "ZenMode",
	},

	{
		"chentoast/marks.nvim",
		opts = {
			refresh_interval = 250,
			sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
		},
		init = function(_, opts)
			vim.cmd("hi! link MarkSignNumHL CursorLineNr")
		end,
		event = "BufReadPost",
	},

	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("plugins.configs.colorizer")
		end,
		event = "BufReadPost",
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
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
		opts = {
			delay = 420,
			under_cursor = false,
			filetypes_denylist = {
				"NvimTree",
				"Trouble",
				"Telescope",
				"DiffviewFiles",
				"DiffviewFileHistory",
				"neo-tree",
				"packer",
				"alpha",
				"mason",
			},
		},
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
		event = "BufReadPost",
	},

	-- {
	--  "beauwilliams/focus.nvim",
	--  config = function()
	--      require("plugins.configs.focus")
	--  end,
	--  cmd = "FocusEnable",
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

	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("plugins.configs.scrollbar")
		end,
		event = "BufReadPost",
	},

	{
		"lukas-reineke/virt-column.nvim",
		opts = {
			char = "▕",
			virtcolumn = "100",
		},
		event = "BufReadPost",
	},

	-- {
	--  "gen740/SmoothCursor.nvim",
	--  opts = {
	--      disabled_filetypes = { "lazy", "help" },
	--      disable_float_win = true,
	--  },
	-- },

	-- {
	--  "anuvyklack/windows.nvim",
	--  dependencies = {
	--      "anuvyklack/middleclass",
	--      "anuvyklack/animation.nvim",
	--  },
	--  config = function()
	--      vim.o.winwidth = 10
	--      vim.o.winminwidth = 10
	--      vim.o.equalalways = false
	--      require("windows").setup({
	--          ignore = {
	--              filetype = { "DiffviewFiles" },
	--          },
	--          animation = {
	--              fps = 60,
	--          },
	--      })
	--  end,
	--  event = "VeryLazy",
	-- },

	{
		"kevinhwang91/nvim-hlslens",
		opts = {},
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
}
