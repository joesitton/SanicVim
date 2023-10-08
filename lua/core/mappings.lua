local mappings = {}

mappings.general = {
	n = {
		-- Navigating wrapped lines
		["k"] = { "gk", "Go up" },
		["j"] = { "gj", "Go down" },
		-- Repeat q reg
		["Q"] = { "@q", "Q register" },
		-- Make jumping to marks use cursor pos
		["'"] = { "`", "Jump to mark" },
		-- Use blackhole register for cCxX
		["c"] = { '"_c', "Change" },
		["C"] = { '"_C', "Change" },
		["x"] = { '"_x', "Delete" },
		["X"] = { '"_X', "Delete" },

		-- Windows
		["<C-h>"] = { "<C-w>h", "Focus window left" },
		["<C-l>"] = { "<C-w>l", "Focus window right" },
		["<C-j>"] = { "<C-w>j", "Focus window down" },
		["<C-k>"] = { "<C-w>k", "Focus window up" },

		-- Saving
		["<leader>w"] = { "<CMD>w<CR>", "Save file" },
		["<leader>x"] = { "<CMD>x<CR>", "Save and exit" },

		["<CR>"] = { "<CMD>nohlsearch<CR>", "Clear search" },
		["<F2>"] = { "<CMD>ZenMode<CR>", "Zen mode" },
	},

	o = {
		["c"] = { '"_c', "Change" },
		["C"] = { '"_C', "Change" },
		["x"] = { '"_x', "Delete" },
		["X"] = { '"_X', "Delete" },
	},

	v = {
		["<"] = { "<gv", "Indent left" },
		[">"] = { ">gv", "Indent right" },
	},
}

mappings.buffers = {
	n = {
		["]b"] = { "<CMD>BufferNext<CR>", "Next buffer" },
		["[b"] = { "<CMD>BufferPrevious<CR>", "Previous buffer" },
		["<C-Left>"] = { "<CMD>BufferMovePrevious<CR>", "Move buffer left" },
		["<C-Right>"] = { "<CMD>BufferMoveNext<CR>", "Move buffer right" },
		["<leader>b"] = "Buffer",
		["<leader>bd"] = { "<CMD>BufferDelete<CR>", "Delete buffer" },
		["<leader>bD"] = { "<CMD>BufferWipeout<CR>", "Wipe buffer" },
		["<leader>bp"] = { "<CMD>BufferPin<CR>", "Pin buffer" },
		["<leader>pb"] = { "<CMD>BufferPick<CR>", "Pick buffer" },
	},
}

mappings.tabs = {
	n = {
		["]t"] = { "<CMD>:tabnext<CR>", "Go to next tab" },
		["[t"] = { "<CMD>:tabprev<CR>", "Previous tab" },
	},
}

-- mappings.minimap = {
-- 	n = {
-- 		["<leader>m"] = { ":lua require('codewindow').toggle_minimap()<CR>", "Toggle minimap" },
-- 	}
-- }

mappings.comments = {
	n = {
		["<C-/>"] = { "<Plug>(comment_toggle_linewise_current)", "Comment selection" },
		["<C-_>"] = { "<Plug>(comment_toggle_linewise_current)", "Comment selection" },
		["gc"] = "Comment",
		["gcf"] = {
			function()
				local comment = vim.fn.input("Comment: ", "")
				vim.cmd([[norm! O<ESC>]])
				local row = vim.api.nvim_win_get_cursor(0)[1]
				vim.api.nvim_buf_set_lines(0, row - 1, row, false, { comment })
				require("comment-box").llbox()
			end,
			"Comment box",
		},
	},

	v = {
		["<C-/>"] = { "<Plug>(comment_toggle_linewise_visual)gv", "Comment selection" },
		["<C-_>"] = { "<Plug>(comment_toggle_linewise_visual)gv", "Comment selection" },
	},
}

mappings.move = {
	n = {
		["<C-S-j>"] = { ":MoveLine(1)<CR>", "Move line down" },
		["<C-S-k>"] = { ":MoveLine(-1)<CR>", "Move line up" },
	},

	v = {
		["<C-S-j>"] = { ":MoveBlock(1)<CR>", "Move block down" },
		["<C-S-k>"] = { ":MoveBlock(-1)<CR>", "Move block up" },
		["<C-S-h>"] = { "<gv", "Move block left" },
		["<C-S-l>"] = { ">gv", "Move block left" },
	},
}

mappings.illuminate = {
	n = {
		["<C-n>"] = {
			function()
				require("illuminate").goto_next_reference({ wrap = true })
			end,
			"Go to next variable occurrence",
		},
		["<C-p>"] = {
			function()
				require("illuminate").goto_prev_reference({ wrap = true })
			end,
			"Previous variable occurrence",
		},
	},
}

mappings.folds = {
	n = {
		["z"] = "Folds",
		["zR"] = {
			function()
				require("ufo").openAllFolds()
			end,
			"Open all folds",
		},
		["zM"] = {
			function()
				require("ufo").closeAllFolds()
			end,
			"Close all folds",
		},
	},
}

mappings.terminal = {
	n = {
		["<F1>"] = { "<CMD>exe v:count1 . 'ToggleTerm'<CR>", "Toggle terminal" },
	},

	t = {
		["<F1>"] = { "<CMD>exe v:count1 . 'ToggleTerm'<CR>", "Toggle terminal" },
	},
}

mappings.tree = {
	n = {
		["\\"] = { "<CMD>NvimTreeToggle<CR>", "Toggle tree" },
	},
}

mappings.git = {
	n = {
		["]g"] = { "<CMD>Gitsigns next_hunk<CR>", "Go to next git hunk" },
		["[g"] = { "<CMD>Gitsigns prev_hunk<CR>", "Previous git hunk" },
	},
}

-- mappings.test = {
--     n = {
--         ["]t"] = { "<Plug>(ultest-next-fail)", "Go to next failed test" },
--         ["[t"] = { "<Plug>(ultest-prev-fail)", "Previous failed test" },
--     },
-- }

mappings.flash = {
	n = {
		["s"] = {
			function()
				require("flash").jump({
					search = { forward = true, wrap = false, multi_window = false },
				})
			end,
			"Flash search forward",
		},
		["S"] = {
			function()
				require("flash").jump({
					search = { forward = false, wrap = false, multi_window = false },
				})
			end,
			"Flash search forward",
		},
	},
}

mappings.marks = {
	n = {
		["]m"] = { "<CMD>lua require('harpoon.ui').nav_next()<CR>", "Go to next harpooned file" },
		["[m"] = { "<CMD>lua require('harpoon.ui').nav_prev()<CR>", "Go to previous harpooned file" },
		["<leader>am"] = {
			function()
				require("harpoon.mark").add_file()
				vim.notify("marked")
			end,
			"Add file to harpoon marks",
		},
	},
}

mappings.lsp = {
	n = {
		["]d"] = { "<CMD>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic" },
		["[d"] = { "<CMD>lua vim.diagnostic.goto_prev()<CR>", "Previous diagnostic" },
		["<leader>ca"] = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code action" },
		["<leader>rn"] = { "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename variable" },
	},

	v = {
		["<leader>ca"] = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code action" },
	},
}

mappings.session = {
	n = {
		["<leader>s"] = "Session",
		["<leader>ss"] = { "<CMD>SessionSave<CR>", "Save session" },
		["<leader>sd"] = { "<CMD>SessionDelete<CR>", "Delete session" },
	},
}

mappings.telescope = {
	n = {
		["<leader>f"] = "Find",
		["<leader>ff"] = { "<CMD>Telescope find_files prompt_prefix=Files\\ ❯\\ <CR>", "Find files" },
		["<leader>ft"] = { "<CMD>Telescope live_grep prompt_prefix=Text\\ ❯\\ <CR>", "Find text" },
		["<leader>fr"] = { "<CMD>Telescope oldfiles prompt_prefix=Recent\\ Files\\ ❯\\ <CR>", "Find recent files" },
		["<leader>fd"] = {
			"<CMD>Telescope diagnostics prompt_prefix=Diagnostics\\ ❯\\ <CR>",
			"Find workspace diagnostics",
		},
		["<leader>fs"] = { "<CMD>Telescope aerial prompt_prefix=Symbols\\ ❯\\ <CR>", "Find buffer symbols" },
		["<leader>fb"] = { "<CMD>Telescope buffers prompt_prefix=Buffers\\ ❯\\ <CR>", "Find buffers" },
		-- ["<leader>fp"] = { "<CMD>Telescope projects prompt_prefix=Projects\\ ❯\\ <CR>", "Find projects" },
		["<leader>fk"] = { "<CMD>Telescope keymaps prompt_prefix=Keybinds\\ ❯\\ <CR>", "Find keymaps" },
		["<leader>fy"] = { "<CMD>Telescope neoclip prompt_prefix=Yanks\\ ❯\\ <CR>", "Find yanks" },
		["<leader>fn"] = { "<CMD>Telescope notify prompt_prefix=Notifications\\ ❯\\ <CR>", "Find notifications" },
		["<leader>fS"] = { "<CMD>Telescope persisted prompt_prefix=Sessions\\ ❯\\ <CR>", "Find sessions" },
		["<leader>fm"] = { "<CMD>Telescope harpoon marks prompt_prefix=Marks\\ ❯\\ <CR>", "Find harpoon marks" },
		["<leader>f'"] = { "<CMD>Telescope marks prompt_prefix=Marks\\ ❯\\ <CR>", "Find marks" },
		["<leader>fu"] = { "<CMD>Telescope undo prompt_prefix=Undo\\ ❯\\ <CR>", "Find undos" },

		["<leader>gs"] = { "<CMD>Telescope git_status prompt_prefix=Git\\ status\\ ❯\\ <CR>", "Git status" },
		["<leader>gb"] = { "<CMD>Telescope git_branches prompt_prefix=Git\\ branches\\ ❯\\ <CR>", "Git branches" },
		["<leader>gc"] = { "<CMD>Telescope conventional_commits theme=dropdown<CR>", "Git commit" },

		["gd"] = { "<CMD>Telescope lsp_definitions prompt_prefix=Definitions\\ ❯\\ <CR>", "Go to definition" },
		["gr"] = { "<CMD>Telescope lsp_references prompt_prefix=References\\ ❯\\ <CR>", "Go to references" },
	},
}

mappings.search = {
	n = {
		["n"] = {
			"<CMD>execute('normal! ' . v:count1 . 'n')<CR>:lua require('hlslens').start()<CR>",
			"Go to next match",
		},
		["N"] = {
			"<CMD>execute('normal! ' . v:count1 . 'N')<CR>:lua require('hlslens').start()<CR>",
			"Previous match",
		},
		["*"] = { "*:lua require('hlslens').start()<CR>", "Go to next match" },
		["#"] = { "#:lua require('hlslens').start()<CR>", "Previous match" },
	},
}

return mappings
