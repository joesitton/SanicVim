vim.g.mapleader = " "

local mappings = {}

mappings.general = {
    n = {
        ["k"] = { "gk", "Go up" },
        ["j"] = { "gj", "Go down" },
        ["Q"] = { "@q", "Q register" },
        ["'"] = { "`", "Jump to mark" },

        ["<C-h>"] = { "<C-w>h", "Focus window left" },
        ["<C-l>"] = { "<C-w>l", "Focus window right" },
        ["<C-j>"] = { "<C-w>j", "Focus window down" },
        ["<C-k>"] = { "<C-w>k", "Focus window up" },

        ["<leader>w"] = { ":w<CR>", "Save file" },
        ["<leader>x"] = { ":x<CR>", "Save and exit" },
        ["<CR>"] = { ":nohlsearch<CR>", "Clear search" },

        -- ["<C-c>"] = { ":%y+<CR>", "Copy file contents" },

        ["K"] = {
            function()
                local winid = require("ufo").peekFoldedLinesUnderCursor()

                if not winid then
                    require("gitsigns").preview_hunk()
                end
            end,
            "Peek fold / Show info",
        },
    },

    i = {
        ["<C-z>"] = {
            function()
                return vim.cmd([[ undo ]])
            end,
            "Undo",
        },
        ["<C-y>"] = {
            function()
                return vim.cmd([[ redo ]])
            end,
            "Redo",
        },
    },

    v = {
        ["<"] = { "<gv", "Indent left" },
        [">"] = { ">gv", "Indent right" },
    },
}

mappings.buffers = {
    n = {
        ["]b"] = { ":BufferNext<CR>", "Next buffer" },
        ["[b"] = { ":BufferPrevious<CR>", "Previous buffer" },
        ["<leader>bd"] = { ":BufferClose<CR>", "Delete buffer" },
        ["<leader>bD"] = { ":BufferWipeout!<CR>", "Wipe buffer" },
        ["<leader>bp"] = { ":BufferPin<CR>", "Pin buffer" },
        ["<C-Left>"] = { ":BufferMovePrevious<CR>", "Move buffer left" },
        ["<C-Right>"] = { ":BufferMoveNext<CR>", "Move buffer right" },
        ["<leader>pb"] = { ":BufferPick<CR>", "Pick buffer" },
    },
}

mappings.comments = {
    n = {
        ["<C-/>"] = { "<Plug>(comment_toggle_current_linewise)", "Comment line" },
    },

    v = {
        ["<C-/>"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment selection" },
    },
}

mappings.illuminate = {
    n = {
        ["<C-n>"] = {
            function()
                require("illuminate").next_reference({ wrap = true })
            end,
            "Next variable occurrence",
        },
        ["<C-p>"] = {
            function()
                require("illuminate").next_reference({ wrap = true, reverse = true })
            end,
            "Previous variable occurrence",
        },
    },
}

mappings.terminal = {
    n = {
        ["<F1>"] = { "<Cmd>exe v:count1 . 'ToggleTerm'<CR>", "Toggle terminal" },
    },

    t = {
        ["<F1>"] = { "<Cmd>exe v:count1 . 'ToggleTerm'<CR>", "Toggle terminal" },
    },
}

mappings.tree = {
    n = {
        ["\\"] = { ":NeoTreeFloatToggle<CR>", "Toggle tree" },
        ["g\\"] = { ":Neotree reveal toggle git_status<CR>", "Git status" },
    },
}

mappings.git = {
    n = {
        ["]g"] = { ":Gitsigns next_hunk<CR>", "Next git hunk" },
        ["[g"] = { ":Gitsigns prev_hunk<CR>", "Previous git hunk" },
    },
}

-- mappings.test = {
--     n = {
--         ["]t"] = { "<Plug>(ultest-next-fail)", "Next failed test" },
--         ["[t"] = { "<Plug>(ultest-prev-fail)", "Previous failed test" },
--     },
-- }

mappings.hop = {
    n = {
        ["s"] = { ":HopChar2AC<CR>", "Hop 2-char forwards" },
        ["S"] = { ":HopChar2BC<CR>", "Hop 2-char backwards" },
        ["f"] = { ":HopChar1CurrentLineAC<CR>", "Hop 1-char forwards" },
        ["F"] = { ":HopChar1CurrentLineBC<CR>", "Hop 1-char backwards" },
    },

    o = {
        ["K"] = { ":HopLineBC<CR>", "Hop up" },
        ["J"] = { ":HopLineAC<CR>", "Hop down" },
        ["f"] = {
            function()
                require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })
            end,
            "Hop 1-char forwards",
        },
        ["F"] = {
            function()
                require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR })
            end,
            "Hop 1-char backwards",
        },
    },

    v = {
        ["f"] = {
            function()
                require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })
            end,
            "Hop 1-char forwards",
        },
        ["F"] = {
            function()
                require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR })
            end,
            "Hop 1-char backwards",
        },
    },
}

mappings.lsp = {
    n = {
        ["]d"] = { ":lua vim.diagnostic.goto_next()<CR>", "Next diagnostic" },
        ["[d"] = { ":lua vim.diagnostic.goto_prev()<CR>", "Previous diagnostic" },
        ["<leader>ca"] = { ":lua vim.lsp.buf.code_action()<CR>", "Code action" },
        -- ["<leader>rn"] = { ":lua require('inc_rename').rename()<CR>", "Rename variable" },
    },

    v = {
        ["<leader>ca"] = { ":lua vim.lsp.buf.code_action()<CR>", "Code action" },
    },
}

mappings.session = {
    n = {
        ["<leader>ss"] = { ":SaveSession<CR>", "Save session" },
        ["<leader>ds"] = { ":DeleteSession<CR>", "Delete session" },
    },
}

mappings.telescope = {
    n = {
        ["<leader>ff"] = { "<CMD>Telescope find_files<CR>", "Find files" },
        ["<leader>ft"] = { "<CMD>Telescope live_grep<CR>", "Find text" },
        ["<leader>fr"] = { "<CMD>Telescope oldfiles<CR>", "Find recent files" },
        ["<leader>fm"] = { "<CMD>Telescope marks<CR>", "Find marks" },
        ["<leader>fd"] = { "<CMD>Telescope diagnostics bufnr=0<CR>", "Find buffer diagnostics" },
        ["<leader>fD"] = { "<CMD>Telescope diagnostics<CR>", "Find workspace diagnostics" },
        ["<leader>fs"] = { "<CMD>Telescope aerial<CR>", "Find buffer symbols" },
        ["<leader>fb"] = { "<CMD>Telescope buffers<CR>", "Find buffers" },
        ["<leader>fp"] = { "<CMD>Telescope projects<CR>", "Find projects" },
        ["<leader>fk"] = { "<CMD>Telescope keymaps<CR>", "Find keymaps" },
        ["<leader>fy"] = { "<CMD>Telescope neoclip<CR>", "Find yanks" },

        ["<leader>gs"] = { "<CMD>Telescope git_status<CR>", "Git status" },
        ["<leader>gb"] = { "<CMD>Telescope git_branches<CR>", "Git branches" },
        ["<leader>gc"] = { "<CMD>Telescope gitmoji theme=dropdown<CR>", "Git commit" },

        ["gd"] = { "<CMD>Telescope lsp_definitions<CR>", "Go to definition" },
        ["gr"] = { "<CMD>Telescope lsp_references<CR>", "Go to references" },
        ["gt"] = { "<CMD>Telescope lsp_type_definitions<CR>", "Go to type definitions" },
    },
}

mappings.search = {
    n = {
        ["n"] = {
            "<CMD>execute('normal! ' . v:count1 . 'n')<CR><CMD>lua require('hlslens').start()<CR>",
            "Next match",
        },
        ["N"] = {
            "<CMD>execute('normal! ' . v:count1 . 'N')<CR><CMD>lua require('hlslens').start()<CR>",
            "Previous match",
        },
    },
}

-- mappings.aerial = {
--     n = {
--         ["a\\"] = { ":AerialToggle float<CR>", "Toggle aerial" },
--     },
-- }

mappings.iconpicker = {
    n = {
        ["<C-i>"] = { "<CMD>PickIcons<CR>", "Pick icon" },
    },

    i = {
        ["<C-i>"] = { "<CMD>PickIconsInsert<CR>", "Pick icon" },
    },
}

-- mappings.surfer = {
--     n = {
--         ["vx"] = { ":STSSelectMasterNode<CR>", "Select main node" },
--         ["vn"] = { ":STSSelectCurrentNode<CR>", "Select node" },
--         ["[e"] = {
--             function()
--                 vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
--                 return "g@l"
--             end,
--             "Swap node with sibling upwards",
--             expr = true,
--         },
--         ["]e"] = {
--             function()
--                 vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
--                 return "g@l"
--             end,
--             "Swap node with sibling downwards",
--             expr = true,
--         },
--     },
--
--     -- v = {
--     --     ["]e"] = {
--     --         function()
--     --             require("syntax-tree-surfer").surf("next", "visual", true)
--     --         end,
--     --         "Swap node with next sibling",
--     --         -- expr = true,
--     --     },
--     --     ["[e"] = {
--     --         function()
--     --             require("syntax-tree-surfer").surf("prev", "visual", true)
--     --         end,
--     --         "Swap node with previous sibling",
--     --         -- expr = true,
--     --     },
--     -- },
-- }

return mappings
