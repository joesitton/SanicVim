local mappings = {}

mappings.general = {
	n = {
		["k"] = { "gk", "Go up" },
		["j"] = { "gj", "Go down" },

		["Q"] = { "@q", "Q register" },

		["'"] = { "`", "Jump to mark" },

		["c"] = { '"_c', "Change" },
		["C"] = { '"_C', "Change" },
		["x"] = { '"_x', "Delete" },
		["X"] = { '"_X', "Delete" },

		["<C-h>"] = { "<C-w>h", "Focus window left" },
		["<C-l>"] = { "<C-w>l", "Focus window right" },
		["<C-j>"] = { "<C-w>j", "Focus window down" },
		["<C-k>"] = { "<C-w>k", "Focus window up" },

		["<leader>w"] = { "<CMD>w<CR>", "Save file" },
		["<leader>x"] = { "<CMD>x<CR>", "Save and exit" },

		["<CR>"] = { "<CMD>nohlsearch<CR>", "Clear search" },

		["<F2>"] = { "<CMD>ZenMode<CR>", "Zen mode" },

		-- ["<C-c>"] = { "<CMD>%y+<CR>", "Copy file contents" },

		["K"] = {
			function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()

				if not winid then
					require("gitsigns").preview_hunk()
					-- vim.lsp.buf.hover()
				end
			end,
			"Peek fold / Show info",
		},
	},

	o = {
		["c"] = { '"_c', "Change" },
		["C"] = { '"_C', "Change" },
		["x"] = { '"_x', "Delete" },
		["X"] = { '"_X', "Delete" },
	},

	-- i = {
	--     ["<D-z>"] = {
	--         function()
	--             return vim.cmd([[ undo ]])
	--         end,
	--         "Undo",
	--     },
	--     ["<D-S-z>"] = {
	--         function()
	--             return vim.cmd([[ redo ]])
	--         end,
	--         "Redo",
	--     },
	-- },

	v = {
		["<"] = { "<gv", "Indent left" },
		[">"] = { ">gv", "Indent right" },
	},
}

mappings.buffers = {
	n = {
		["]b"] = { "<CMD>BufferNext<CR>", "Next buffer" },
		["[b"] = { "<CMD>BufferPrevious<CR>", "Previous buffer" },
		["<leader>bd"] = { "<CMD>BufferDelete<CR>", "Delete buffer" },
		["<leader>bD"] = { "<CMD>BufferWipeout<CR>", "Wipe buffer" },
		["<leader>bp"] = { "<CMD>BufferPin<CR>", "Pin buffer" },
		["<C-Left>"] = { "<CMD>BufferMovePrevious<CR>", "Move buffer left" },
		["<C-Right>"] = { "<CMD>BufferMoveNext<CR>", "Move buffer right" },
		["<leader>pb"] = { "<CMD>BufferPick<CR>", "Pick buffer" },
	},
}

mappings.tabs = {
	n = {
		["]t"] = { "<CMD>:tabnext<CR>", "Next tab"},
		["[t"] = { "<CMD>:tabprev<CR>", "Previous tab"},
	}
}

mappings.comments = {
	n = {
		["<C-/>"] = { "<Plug>(comment_toggle_linewise_current)", "Comment line" },
		["<C-_>"] = { "<Plug>(comment_toggle_linewise_current)", "Comment line" },
		["gcf"] = {
			function()
				local comment = vim.fn.input("Comment: ", "")
				vim.cmd([[norm! O<ESC>]])
				local row = vim.api.nvim_win_get_cursor(0)[1]
				vim.api.nvim_buf_set_lines(0, row-1, row, false, {comment})
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
	},
}

mappings.illuminate = {
	n = {
		["<C-n>"] = {
			function()
				require("illuminate").goto_next_reference({ wrap = true })
			end,
			"Next variable occurrence",
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
		["\\"] = { "<CMD>Neotree toggle left<CR>", "Toggle tree" },
		["g\\"] = { "<CMD>Neotree toggle left git_status<CR>", "Git status" },
	},
}

mappings.git = {
	n = {
		["]g"] = { "<CMD>Gitsigns next_hunk<CR>", "Next git hunk" },
		["[g"] = { "<CMD>Gitsigns prev_hunk<CR>", "Previous git hunk" },
		["grh"] = { "<CMD>Gitsigns reset_hunk<CR>", "Reset hunk"},
	},
}

-- mappings.test = {
--     n = {
--         ["]t"] = { "<Plug>(ultest-next-fail)", "Next failed test" },
--         ["[t"] = { "<Plug>(ultest-prev-fail)", "Previous failed test" },
--     },
-- }

-- local hop_directions = {
-- 	AFTER = require("hop.hint").HintDirection.AFTER_CURSOR,
-- 	BEFORE = require("hop.hint").HintDirection.BEFORE_CURSOR,
-- }

-- local hop_maps = {
-- 	["f"] = {
-- 		function()
-- 			require("hop").hint_char1({ direction = hop_directions.AFTER, current_line_only = true })
-- 		end,
-- 		"Hop 1-char forwards",
-- 	},
-- 	["F"] = {
-- 		function()
-- 			require("hop").hint_char1({ direction = hop_directions.BEFORE, current_line_only = true })
-- 		end,
-- 		"Hop 1-char backwards",
-- 	},
-- 	["t"] = {
-- 		function()
-- 			require("hop").hint_char1({ direction = hop_directions.AFTER, current_line_only = true, hint_offset = -1 })
-- 		end,
-- 		"Hop 1-char forwards",
-- 	},
-- 	["T"] = {
-- 		function()
-- 			require("hop").hint_char1({ direction = hop_directions.BEFORE, current_line_only = true, hint_offset = 1 })
-- 		end,
-- 		"Hop 1-char backwards",
-- 	},
-- 	["s"] = {
-- 		function()
-- 			require("hop").hint_char2({ direction = hop_directions.AFTER })
-- 		end,
-- 		"Hop 2-char forwards",
-- 	},
-- 	["S"] = {
-- 		function()
-- 			require("hop").hint_char2({ direction = hop_directions.BEFORE })
-- 		end,
-- 		"Hop 2-char backwards",
-- 	},
-- 	["W"] = { "<CMD>HopWordAC<CR>", "Hop forwards to word" },
-- 	["B"] = { "<CMD>HopWordBC<CR>", "Hop backwards to word" },
-- }

-- mappings.hop = {
-- 	n = hop_maps,
-- 	o = hop_maps,
-- 	v = {
-- 		["f"] = {
-- 			function()
-- 				require("hop").hint_char1({ direction = hop_directions.AFTER, current_line_only = true })
-- 			end,
-- 			"Hop 1-char forwards",
-- 		},
-- 		["F"] = {
-- 			function()
-- 				require("hop").hint_char1({ direction = hop_directions.BEFORE, current_line_only = true })
-- 			end,
-- 			"Hop 1-char backwards",
-- 		},
-- 		["t"] = {
-- 			function()
-- 				require("hop").hint_char1({
-- 					direction = hop_directions.AFTER,
-- 					current_line_only = true,
-- 					hint_offset = -1,
-- 				})
-- 			end,
-- 			"Hop 1-char forwards",
-- 		},
-- 		["T"] = {
-- 			function()
-- 				require("hop").hint_char1({
-- 					direction = hop_directions.BEFORE,
-- 					current_line_only = true,
-- 					hint_offset = 1,
-- 				})
-- 			end,
-- 			"Hop 1-char backwards",
-- 		},
-- 		["W"] = { "<CMD>HopWordAC<CR>", "Hop forwards to word" },
-- 		["B"] = { "<CMD>HopWordBC<CR>", "Hop backwards to word" },
-- 	},
-- }

-- mappings.spider = {
-- 	n = {
-- 		["w"] = { "<cmd>lua require('spider').motion('w')<CR>", "Spider w"},
-- 		["e"] = { "<cmd>lua require('spider').motion('e')<CR>", "Spider e"},
-- 		["b"] = { "<cmd>lua require('spider').motion('b')<CR>", "Spider b"}
-- 	},
-- 	o = {
-- 		["w"] = { "<cmd>lua require('spider').motion('w')<CR>", "Spider w"},
-- 		["e"] = { "<cmd>lua require('spider').motion('e')<CR>", "Spider e"},
-- 		["b"] = { "<cmd>lua require('spider').motion('b')<CR>", "Spider b"}
-- 	},
-- 	x = {
-- 		["w"] = { "<cmd>lua require('spider').motion('w')<CR>", "Spider w"},
-- 		["e"] = { "<cmd>lua require('spider').motion('e')<CR>", "Spider e"},
-- 		["b"] = { "<cmd>lua require('spider').motion('b')<CR>", "Spider b"}
-- 	},
-- }

mappings.marks = {
	n = {
		["<leader>m"] = {
			function()
				require("harpoon.mark").add_file()
				vim.notify("Added file to harpoon list")
			end,
			"Add file to harpoon marks",
		},
		["]m"] = { "<CMD>lua require('harpoon.ui').nav_next()<CR>", "Go to next harpooned file" },
		["[m"] = { "<CMD>lua require('harpoon.ui').nav_prev()<CR>", "Go to previous harpooned file" },
	},
}

mappings.lsp = {
	n = {
		["]d"] = { "<CMD>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic" },
		["[d"] = { "<CMD>lua vim.diagnostic.goto_prev()<CR>", "Previous diagnostic" },
		["<leader>ca"] = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code action" },
		["<leader>rn"] = { ":IncRename ", "Rename variable" },
	},

	v = {
		["<leader>ca"] = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code action" },
	},
}

mappings.session = {
	n = {
		["<leader>Ss"] = { "<CMD>SessionSave<CR>", "Save session" },
		["<leader>Sd"] = { "<CMD>SessionDelete<CR>", "Delete session" },
	},
}

mappings.telescope = {
	n = {
		["<leader>ff"] = { "<CMD>Telescope find_files prompt_prefix=Files\\ ❯\\ <CR>", "Find files" },
		["<leader>ft"] = { "<CMD>Telescope live_grep prompt_prefix=Text\\ ❯\\ <CR>", "Find text" },
		["<leader>fr"] = { "<CMD>Telescope oldfiles prompt_prefix=Recent\\ Files\\ ❯\\ <CR>", "Find recent files" },
		-- ["<leader>fd"] = { "<CMD>Telescope diagnostics bufnr=0 prompt_prefix=Diagnostics\\ ❯\\ <CR>", "Find buffer diagnostics" },
		["<leader>fd"] = { "<CMD>Telescope diagnostics prompt_prefix=Diagnostics\\ ❯\\ <CR>", "Find workspace diagnostics" },
		["<leader>fs"] = { "<CMD>Telescope aerial prompt_prefix=Symbols\\ ❯\\ <CR>", "Find buffer symbols" },
		["<leader>fb"] = { "<CMD>Telescope buffers prompt_prefix=Buffers\\ ❯\\ <CR>", "Find buffers" },
		["<leader>fp"] = { "<CMD>Telescope projects prompt_prefix=Projects\\ ❯\\ <CR>", "Find projects" },
		["<leader>fk"] = { "<CMD>Telescope keymaps prompt_prefix=Keybinds\\ ❯\\ <CR>", "Find keymaps" },
		["<leader>fy"] = { "<CMD>Telescope neoclip prompt_prefix=Yanks\\ ❯\\ <CR>", "Find yanks" },
		["<leader>fn"] = { "<CMD>Telescope notify prompt_prefix=Notifications\\ ❯\\ <CR>", "Find notifications" },
		["<leader>fS"] = { "<CMD>Telescope persisted prompt_prefix=Sessions\\ ❯\\ <CR>", "Find sessions" },
		["<leader>fm"] = { "<CMD>Telescope harpoon marks prompt_prefix=Marks\\ ❯\\ <CR>", "Find harpoon marks" },
		["<leader>f'"] = { "<CMD>Telescope marks prompt_prefix=Marks\\ ❯\\ <CR>", "Find marks" },
		["<leader>fu"] = { "<CMD>Telescope undo prompt_prefix=Undo\\ ❯\\ <CR>", "Find undos" },

		["<leader>gs"] = { "<CMD>Telescope git_status prompt_prefix=Git\\ status\\ ❯\\ <CR>", "Git status" },
		["<leader>gb"] = { "<CMD>Telescope git_branches prompt_prefix=Git\\ branches\\ ❯\\ <CR>", "Git branches" },
		["<leader>gc"] = { "<CMD>Telescope gitmoji<CR>", "Git commit" },

		["gd"] = { "<CMD>Telescope lsp_definitions prompt_prefix=Definitions\\ ❯\\ <CR>", "Go to definition" },
		["gr"] = { "<CMD>Telescope lsp_references prompt_prefix=References\\ ❯\\ <CR>", "Go to references" },
	},
}

mappings.search = {
	n = {
		["n"] = {
			"<CMD>execute('normal! ' . v:count1 . 'n')<CR>:lua require('hlslens').start()<CR>",
			"Next match",
		},
		["N"] = {
			"<CMD>execute('normal! ' . v:count1 . 'N')<CR>:lua require('hlslens').start()<CR>",
			"Previous match",
		},
		["*"] = { "*:lua require('hlslens').start()<CR>", "Next match" },
		["#"] = { "#:lua require('hlslens').start()<CR>", "Previous match" },
	},
}

-- mappings.iconpicker = {
--     n = {
--         ["<C-i>"] = { "<CMD>PickEverything<CR>", "Pick icon" },
--     },

--     i = {
--         ["<C-i>"] = { "<CMD>PickEverythingInsert<CR>", "Pick icon" },
--     },
-- }

-- mappings.treesurfer = {
--     n = {
--         ["vm"] = { "<CMD>STSSelectMasterNode<CR>", "Select main node" },
--         ["vn"] = { "<CMD>STSSelectCurrentNode<CR>", "Select node" },
--         ["[e"] = {
--             function()
--                 vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
--                 return "g@l"
--             end,
--             "Swap node with sibling upwards",
--             expr = true,
--         },
--         ["]e"] = {
--             function()
--                 vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
--                 return "g@l"
--             end,
--             "Swap node with sibling upwards",
--             expr = true,
--         },
--         ["[a"] = {
--             function()
--                 vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
--                 return "g@l"
--             end,
--             "Swap node with previous sibling",
--             expr = true,
--         },
--         ["]a"] = {
--             function()
--                 vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
--                 return "g@l"
--             end,
--             "Swap node with next sibling",
--             expr = true,
--         },
--     },

--     v = {
--         -- [">"] = { "<CMD>STSSelectNextSiblingNode<CR>", "Select next sibling node" },
--         -- ["<"] = { "<CMD>STSSelectPrevSiblingNode<CR>", "Select previous sibling node" },
--         [","] = { "<CMD>STSSelectParentNode<CR>", "Select parent node" },
--         ["."] = { "<CMD>STSSelectChildNode<CR>", "Select child node" },
--         ["]e"] = { "<CMD>STSSwapNextVisual<CR>", "Swap selection with next node" },
--         ["[e"] = { "<CMD>STSSwapPrevVisual<CR>", "Swap selection with previous node" },
--     },
-- }

return mappings
