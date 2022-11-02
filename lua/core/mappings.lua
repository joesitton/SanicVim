vim.g.mapleader = " "

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

        ["<leader>w"] = { ":w<CR>", "Save file" },
        ["<leader>x"] = { ":x<CR>", "Save and exit" },

        ["<CR>"] = { ":nohlsearch<CR>", "Clear search" },

        ["<F2>"] = { "<CMD>ZenMode<CR>", "Zen mode" },

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

    o = {
        ["c"] = { '"_c', "Change" },
        ["C"] = { '"_C', "Change" },
        ["x"] = { '"_x', "Delete" },
        ["X"] = { '"_X', "Delete" },
    },

    -- i = {
    --     ["<C-z>"] = {
    --         function()
    --             return vim.cmd([[ undo ]])
    --         end,
    --         "Undo",
    --     },
    --     ["<C-S-z>"] = {
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
        ["<leader>bd"] = { "<CMD>BufferClose<CR>", "Delete buffer" },
        ["<leader>bD"] = { "<CMD>BufferWipeout!<CR>", "Wipe buffer" },
        ["<leader>bp"] = { "<CMD>BufferPin<CR>", "Pin buffer" },
        ["<C-Left>"] = { "<CMD>BufferMovePrevious<CR>", "Move buffer left" },
        ["<C-Right>"] = { "<CMD>BufferMoveNext<CR>", "Move buffer right" },
        ["<leader>pb"] = { "<CMD>BufferPick<CR>", "Pick buffer" },
    },
}

mappings.comments = {
    n = {
        ["<C-/>"] = { "<Plug>(comment_toggle_linewise_current)", "Comment line" },
        ["<C-_>"] = { "<Plug>(comment_toggle_linewise_current)", "Comment line" },
    },

    v = {
        ["<C-/>"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment selection" },
        ["<C-_>"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment selection" },
    },
}

mappings.move = {
    n = {
        ["<C-S-j>"] = { "<CMD>MoveLine(1)<CR>", "Move line down" },
        ["<C-S-k>"] = { "<CMD>MoveLine(-1)<CR>", "Move line up" },
        ["<C-S-l>"] = { "<CMD>MoveHChar(1)<CR>", "Move char right" },
        ["<C-S-h>"] = { "<CMD>MoveHChar(-1)<CR>", "Move char left" },
    },

    -- v = {
    --     ["<C-S-k>"] = { "<CMD>MoveBlock(-1)<CR>", "Move block up" },
    --     ["<C-S-j>"] = { "<CMD>MoveBlock(1)<CR>", "Move block down" },
    --     ["<C-S-l>"] = { "<CMD>MoveHBlock(1)<CR>", "Move block right" },
    --     ["<C-S-h>"] = { "<CMD>MoveHBlock(-1)<CR>", "Move block left" },
    -- },
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
        ["<F1>"] = { "<CMD>exe v:count1 . 'ToggleTerm'<CR>", "Toggle terminal" },
    },

    t = {
        ["<F1>"] = { "<CMD>exe v:count1 . 'ToggleTerm'<CR>", "Toggle terminal" },
    },
}

mappings.tree = {
    n = {
        ["\\"] = { "<CMD>NeoTreeFloatToggle<CR>", "Toggle tree" },
        ["g\\"] = { "<CMD>NeoTreeFloatToggle git_status<CR>", "Git status" },
    },
}

mappings.git = {
    n = {
        ["]g"] = { "<CMD>Gitsigns next_hunk<CR>", "Next git hunk" },
        ["[g"] = { "<CMD>Gitsigns prev_hunk<CR>", "Previous git hunk" },
    },
}

-- mappings.test = {
--     n = {
--         ["]t"] = { "<Plug>(ultest-next-fail)", "Next failed test" },
--         ["[t"] = { "<Plug>(ultest-prev-fail)", "Previous failed test" },
--     },
-- }

local hop_directions = {
    AFTER = require("hop.hint").HintDirection.AFTER_CURSOR,
    BEFORE = require("hop.hint").HintDirection.BEFORE_CURSOR,
}

local hop_maps = {
    ["f"] = {
        function()
            require("hop").hint_char1({ direction = hop_directions.AFTER, current_line_only = true })
        end,
        "Hop 1-char forwards",
    },
    ["F"] = {
        function()
            require("hop").hint_char1({ direction = hop_directions.BEFORE, current_line_only = true })
        end,
        "Hop 1-char backwards",
    },
    ["t"] = {
        function()
            require("hop").hint_char1({ direction = hop_directions.AFTER, current_line_only = true, hint_offset = -1 })
        end,
        "Hop 1-char forwards",
    },
    ["T"] = {
        function()
            require("hop").hint_char1({ direction = hop_directions.BEFORE, current_line_only = true, hint_offset = 1 })
        end,
        "Hop 1-char backwards",
    },
    ["s"] = {
        function()
            require("hop").hint_char2({ direction = hop_directions.AFTER })
        end,
        "Hop 2-char forwards",
    },
    ["S"] = {
        function()
            require("hop").hint_char2({ direction = hop_directions.BEFORE })
        end,
        "Hop 2-char backwards",
    },
    ["W"] = { "<CMD>HopWordAC<CR>", "Hop forwards to word" },
    ["B"] = { "<CMD>HopWordBC<CR>", "Hop backwards to word" },
}

mappings.hop = {
    n = hop_maps,
    o = hop_maps,
    v = {
        ["f"] = {
            function()
                require("hop").hint_char1({ direction = hop_directions.AFTER, current_line_only = true })
            end,
            "Hop 1-char forwards",
        },
        ["F"] = {
            function()
                require("hop").hint_char1({ direction = hop_directions.BEFORE, current_line_only = true })
            end,
            "Hop 1-char backwards",
        },
        ["t"] = {
            function()
                require("hop").hint_char1({
                    direction = hop_directions.AFTER,
                    current_line_only = true,
                    hint_offset = -1,
                })
            end,
            "Hop 1-char forwards",
        },
        ["T"] = {
            function()
                require("hop").hint_char1({
                    direction = hop_directions.BEFORE,
                    current_line_only = true,
                    hint_offset = 1,
                })
            end,
            "Hop 1-char backwards",
        },
    },
}

mappings.harpoon = {
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
        ["<leader>ss"] = { "<CMD>SaveSession<CR>", "Save session" },
        ["<leader>ds"] = { "<CMD>DeleteSession<CR>", "Delete session" },
    },
}

mappings.telescope = {
    n = {
        ["<leader>ff"] = { "<CMD>Telescope find_files<CR>", "Find files" },
        ["<leader>ft"] = { "<CMD>Telescope live_grep<CR>", "Find text" },
        ["<leader>fr"] = { "<CMD>Telescope oldfiles<CR>", "Find recent files" },
        ["<leader>fm"] = { "<CMD>Telescope harpoon marks<CR>", "Find marks" },
        ["<leader>fd"] = { "<CMD>Telescope diagnostics bufnr=0<CR>", "Find buffer diagnostics" },
        ["<leader>fD"] = { "<CMD>Telescope diagnostics<CR>", "Find workspace diagnostics" },
        ["<leader>fs"] = { "<CMD>Telescope aerial<CR>", "Find buffer symbols" },
        ["<leader>fb"] = { "<CMD>Telescope buffers<CR>", "Find buffers" },
        ["<leader>fp"] = { "<CMD>Telescope projects theme=dropdown<CR>", "Find projects" },
        ["<leader>fk"] = { "<CMD>Telescope keymaps<CR>", "Find keymaps" },
        ["<leader>fy"] = { "<CMD>Telescope neoclip<CR>", "Find yanks" },
        ["<leader>fn"] = { "<CMD>Telescope notify<CR>", "Find notifications" },
        ["<leader>fS"] = { "<CMD>Telescope session-lens search_session<CR>", "Find sessions" },
        ["<leader>f'"] = { "<CMD>Telescope marks<CR>", "Find marks" },

        ["<leader>gs"] = { "<CMD>Telescope git_status<CR>", "Git status" },
        ["<leader>gb"] = { "<CMD>Telescope git_branches<CR>", "Git branches" },
        ["<leader>gc"] = { "<CMD>Telescope gitmoji theme=dropdown<CR>", "Git commit" },

        ["gd"] = { "<CMD>Telescope lsp_definitions<CR>", "Go to definition" },
        ["gr"] = { "<CMD>Telescope lsp_references<CR>", "Go to references" },
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
        ["*"] = { "*<CMD>lua require('hlslens').start()<CR>", "Next match" },
        ["#"] = { "#<CMD>lua require('hlslens').start()<CR>", "Previous match" },
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
