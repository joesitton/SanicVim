local g = vim.g

g.mapleader = " "

local mappings = {}

mappings.general = {
    n = {
        ["<C-h>"] = { "<C-w>h", "window left" },
        ["<C-l>"] = { "<C-w>l", "window right" },
        ["<C-j>"] = { "<C-w>j", "window down" },
        ["<C-k>"] = { "<C-w>k", "window up" },

        ["<leader>w"] = { ":w<CR>", "save file" },

        ["<C-c>"] = { ":%y+<CR>", "copy file contents" },
    },

    i = {
        ["<C-z>"] = {
            function()
                return vim.cmd([[ undo ]])
            end,
            "undo",
        },
        ["<C-y>"] = {
            function()
                return vim.cmd([[ redo ]])
            end,
            "redo",
        },
    },
}

mappings.buffers = {
    n = {
        ["]b"] = { ":BufferNext<CR>", "next buffer" },
        ["[b"] = { ":BufferPrevious<CR>", "previous buffer" },
        ["<leader>bd"] = { ":BufferClose<CR>", "delete buffer" },
        ["<leader>bD"] = { ":BufferWipeout!<CR>", "wipe buffer" },
        ["<leader>bp"] = { ":BufferPin<CR>", "pin buffer" },
        ["<C-Left>"] = { "BufferMovePrevious<CR>", "move buffer left" },
        ["<C-Right>"] = { "BufferMoveNext<CR>", "move buffer right" },
        ["<leader>pb"] = { "BufferPick<CR>", "pick buffer" },
    },
}

mappings.comments = {
    n = {
        ["<C-_>"] = { "<Plug>kommentary_line_default", "comment line" },
    },

    v = {
        ["<C-_>"] = { "<Plug>kommentary_visual_default", "comment selection" },
    },
}

mappings.illuminate = {
    n = {
        ["<C-n>"] = { ":lua require('illuminate').next_reference {wrap = true}<CR>", "next variable occurrence" },
        ["<C-p>"] = {
            ":lua require('illuminate').next_reference {reverse = true, wrap = true}<CR>",
            "previous variable occurrence",
        },
    },
}

mappings.terminal = {
    n = {
        ["<F1>"] = { "<CMD>execute v:count1 . 'ToggleTerm'<CR>", "toggle terminal" },
    },

    t = {
        ["<F1>"] = { "<CMD>execute v:count1 . 'ToggleTerm'<CR>", "toggle terminal" },
    },
}

mappings.tree = {
    n = {
        ["\\"] = { ":NeoTreeRevealToggle<CR>", "toggle tree" },
        ["g\\"] = { ":Neotree reveal toggle git_status", "git status" },
    },
}

mappings.test = {
    n = {
        ["]t"] = { "<Plug>(ultest-next-fail)", "next failed test" },
        ["[t"] = { "<Plug>(ultest-prev-fail)", "previous failed test" },
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
        ["K"] = { ":HopLineBC<CR>", "hop up" },
        ["J"] = { ":HopLineAC<CR>", "hop down" },
        ["s"] = { ":HopChar2AC<CR>", "hop 2-char forwards" },
        ["S"] = { ":HopChar2BC<CR>", "hop 2-char backwards" },
        ["f"] = { ":HopChar1CurrentLineAC<CR>", "hop 1-char forwards" },
        ["F"] = { ":HopChar1CurrentLineBC<CR>", "hop 1-char backwards" },
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
            "hop after 1-char backwards",
        },
    },

    o = {
        ["K"] = { ":HopLineBC<CR>", "hop up" },
        ["J"] = { ":HopLineAC<CR>", "hop down" },
        ["f"] = { ":HopChar1CurrentLineAC<CR>", "hop 1-char forwards" },
        ["F"] = { ":HopChar1CurrentLineBC<CR>", "hop 1-char backwards" },
    },

    v = {
        ["s"] = { ":HopChar2AC<CR>", "hop 2-char forwards" },
        ["S"] = { ":HopChar2BC<CR>", "hop 2-char backwards" },
        ["f"] = {
            function()
                require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })
            end,
            "hop 1-char forwards",
        },
        ["F"] = {
            function()
                require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR })
            end,
            "hop 1-char backwards",
        },
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
            "hop after 1-char backwards",
        },
    },
}

mappings.lsp = {
    n = {
        ["]d"] = { ":lua vim.diagnostic.goto_next()<CR>", "next diagnostic" },
        ["[d"] = { ":lua vim.diagnostic.goto_prev()<CR>", "previous diagnostic" },
        ["<leader>ca"] = { ":lua vim.lsp.buf.code_action()<CR>", "code action" },
        ["<leader>rn"] = { ":lua vim.lsp.buf.rename()<CR>", "rename variable" },
    },

    v = {
        ["<leader>ca"] = { ":lua vim.lsp.buf.code_action()<CR>", "code action" },
    },
}

mappings.session = {
    n = {
        ["<leader>ss"] = { ":SaveSession<CR>", "save session" },
        ["<leader>ds"] = { ":DeleteSession<CR>", "delete session" },
    },
}

mappings.telescope = {
    n = {
        ["<leader>ff"] = { ":Telescope find_files<CR>", "find files" },
        ["<leader>ft"] = { ":Telescope live_grep<CR>", "find text" },
        ["<leader>fr"] = { ":Telescope frecency<CR>", "find recent files" },
        ["<leader>fm"] = { ":Telescope marks<CR>", "find marks" },
        ["<leader>fd"] = { ":Telescope diagnostics<CR>", "find buffer diagnostics" },
        ["<leader>fs"] = { ":Telescope lsp_document_symbols<CR>", "find buffer symbols" },
        ["<leader>fb"] = { ":Telescope buffers<CR>", "find buffers" },
        ["<leader>fp"] = { ":Telescope projects<CR>", "find projects" },
        ["<leader>fk"] = { ":Telescope keymaps<CR>", "find keymaps" },

        ["<leader>gs"] = { ":Telescope git_status<CR>", "git status" },
        ["<leader>gb"] = { ":Telescope git_branches<CR>", "git branches" },

        ["<leader>gd"] = { ":Telescope lsp_definitions<CR>", "go to definition" },
        ["<leader>gr"] = { ":Telescope lsp_references<CR>", "go to references" },
    },
}

return mappings
