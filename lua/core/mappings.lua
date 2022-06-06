vim.g.mapleader = " "

for _, key in ipairs({ "x", "X", "c", "C" }) do
    vim.keymap.set({ "n", "v" }, key, '"_' .. key)
end

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

        ["<C-c>"] = { ":%y+<CR>", "Copy file contents" },
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
        ["<C-_>"] = { "<Plug>kommentary_line_default", "Comment line" },
    },

    v = {
        ["<C-_>"] = { "<Plug>kommentary_visual_default", "Comment selection" },
    },
}

mappings.illuminate = {
    n = {
        ["<C-n>"] = {
            function()
                return require("illuminate").next_reference({ wrap = true })
            end,
            "Next variable occurrence",
        },
        ["<C-p>"] = {
            function()
                return require("illuminate").next_reference({ wrap = true, reverse = true })
            end,
            "Previous variable occurrence",
        },
    },
}

mappings.terminal = {
    n = {
        ["<F1>"] = { "<CMD>execute v:count1 . 'ToggleTerm'<CR>", "Toggle terminal" },
    },

    t = {
        ["<F1>"] = { "<CMD>execute v:count1 . 'ToggleTerm'<CR>", "Toggle terminal" },
    },
}

mappings.tree = {
    n = {
        ["\\"] = { ":NeoTreeRevealToggle<CR>", "Toggle tree" },
        ["g\\"] = { ":Neotree reveal toggle git_status", "Git status" },
    },
}

mappings.test = {
    n = {
        ["]t"] = { "<Plug>(ultest-next-fail)", "Next failed test" },
        ["[t"] = { "<Plug>(ultest-prev-fail)", "Previous failed test" },
    },
}

local function HopChar1Inc(direction)
    return require("hop").hint_char1({
        direction = require("hop.hint").HintDirection[direction],
        inclusive_jump = true,
        current_line_only = true,
    })
end

mappings.hop = {
    n = {
        ["K"] = { ":HopLineBC<CR>", "Hop up" },
        ["J"] = { ":HopLineAC<CR>", "Hop down" },
        ["s"] = { ":HopChar2AC<CR>", "Hop 2-char forwards" },
        ["S"] = { ":HopChar2BC<CR>", "Hop 2-char backwards" },
        ["f"] = { ":HopChar1CurrentLineAC<CR>", "Hop 1-char forwards" },
        ["F"] = { ":HopChar1CurrentLineBC<CR>", "Hop 1-char backwards" },
        ["t"] = {
            function()
                return HopChar1Inc("AFTER_CURSOR")
            end,
            "hop after 1-char forwards",
        },
        ["T"] = {
            function()
                return HopChar1Inc("BEFORE_CURSOR")
            end,
            "Hop after 1-char backwards",
        },
    },

    o = {
        ["K"] = { ":HopLineBC<CR>", "Hop up" },
        ["J"] = { ":HopLineAC<CR>", "Hop down" },
        ["f"] = { ":HopChar1CurrentLineAC<CR>", "Hop 1-char forwards" },
        ["F"] = { ":HopChar1CurrentLineBC<CR>", "Hop 1-char backwards" },
    },

    v = {
        ["s"] = { ":HopChar2AC<CR>", "Hop 2-char forwards" },
        ["S"] = { ":HopChar2BC<CR>", "Hop 2-char backwards" },
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
        ["t"] = {
            function()
                return HopChar1Inc("AFTER_CURSOR")
            end,
            "Hop after 1-char forwards",
        },
        ["T"] = {
            function()
                return HopChar1Inc("BEFORE_CURSOR")
            end,
            "Hop after 1-char backwards",
        },
    },
}

mappings.lsp = {
    n = {
        ["]d"] = { ":lua vim.diagnostic.goto_next()<CR>", "Next diagnostic" },
        ["[d"] = { ":lua vim.diagnostic.goto_prev()<CR>", "Previous diagnostic" },
        ["<leader>ca"] = { ":lua vim.lsp.buf.code_action()<CR>", "Code action" },
        ["<leader>rn"] = { ":lua vim.lsp.buf.rename()<CR>", "Rename variable" },
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
        ["<leader>ff"] = { ":Telescope find_files<CR>", "Find files" },
        ["<leader>ft"] = { ":Telescope live_grep<CR>", "Find text" },
        ["<leader>fr"] = { ":Telescope frecency<CR>", "Find recent files" },
        ["<leader>fm"] = { ":Telescope marks<CR>", "Find marks" },
        ["<leader>fd"] = { ":Telescope diagnostics<CR>", "Find buffer diagnostics" },
        ["<leader>fs"] = { ":Telescope lsp_document_symbols<CR>", "Find buffer symbols" },
        ["<leader>fb"] = { ":Telescope buffers<CR>", "Find buffers" },
        ["<leader>fp"] = { ":Telescope projects<CR>", "Find projects" },
        ["<leader>fk"] = { ":Telescope keymaps<CR>", "Find keymaps" },

        ["<leader>gs"] = { ":Telescope git_status<CR>", "Git status" },
        ["<leader>gb"] = { ":Telescope git_branches<CR>", "Git branches" },

        ["<leader>gd"] = { ":Telescope lsp_definitions<CR>", "Go to definition" },
        ["<leader>gr"] = { ":Telescope lsp_references<CR>", "Go to references" },
    },
}

return mappings