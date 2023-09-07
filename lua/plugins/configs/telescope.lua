local status_ok, actions = pcall(require, "telescope.actions")

if not status_ok then
	return
end

local telescope = require("telescope")

require("telescope.pickers.layout_strategies").custom_layout = function(picker, max_columns, max_lines, layout_config)
	local layout =
		require("telescope.pickers.layout_strategies").bottom_pane(picker, max_columns, max_lines, layout_config)
	layout.prompt.title = ""
	layout.results.line = layout.results.line + 1
	layout.results.height = layout.results.height - 1
	return layout
end

telescope.setup({
	defaults = {
		prompt_prefix = "❯ ",
		multi_icon = "• ",
		-- dynamic_preview_title = true,
		treesitter = true,
		selection_caret = "  ",
		scroll_strategy = "limit",
		sorting_strategy = "ascending",
		layout_strategy = "custom_layout",
		layout_config = {
			height = 0.54,
		},
		results_title = "",
		preview_title = "",
		prompt_title = "",
		winblend = 2,
		border = true,
		borderchars = {
			prompt = { "▔", " ", " ", " ", "▔", "▔", " ", " " },
			preview = { " ", " ", " ", "⎢", " ", " ", " ", " " },
			results = { " ", " ", " ", " ", " ", " ", " ", " " },
		},
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<Tab>"] = actions.move_selection_next,
				["<S-Tab>"] = actions.move_selection_previous,
				["<CR>"] = actions.select_default + actions.center,
				["<ESC>"] = actions.close,
				["<C-Space>"] = require("telescope.actions.layout").toggle_preview,
			},
			n = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--trim",
		},
		file_ignore_patterns = {
			"node_modules",
			-- ".git",
			"venv",
			".venv",
			"__pycache__",
			".tox",
		},
		use_less = true,
	},
	-- pickers = {
	-- },
	extensions = {
		aerial = {
			show_nesting = true,
		},
		persisted = {
			layout_config = {
				width = 0.4,
				height = 0.5,
			},
		},
		projects = {
			layout_config = {
				width = 0.4,
				height = 0.5,
			},
		},
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		undo = {
			side_by_side = true,
			prompt_prefix = "Undo ❯ "
		},
		gitmoji = {
			action = function(entry)
				vim.ui.input({ prompt = "Commit: " }, function(msg)
					if not msg then
						return
					end

					local git_tool = ":!git"

					if vim.g.loaded_fugitive then
						git_tool = ":G"
					end

					vim.cmd(string.format('%s commit -m "%s %s"', git_tool, entry.value, msg))
				end)
			end,
		},
	},
})
