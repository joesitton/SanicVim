local wk = require("which-key")

wk.setup({
    plugins = {
        marks = false,
        registers = false,
        presets = {
            operators = false,
            text_objects = true,
            motions = false,
            windows = false,
            nav = false,
            z = false,
            g = false,
        },
    },
    icons = {
        separator = "  ", -- symbol used between a key and it's label
    },
    key_labels = {
        ["<leader>"] = "SPC",
        ["<CR>"] = "RET",
    },
    window = {
        border = "rounded", -- none/single/double/shadow
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    },
    layout = {
        spacing = 8, -- spacing between columns
        align = "center",
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
})

wk.register({
    ["<leader>"] = {
        w = { "<CMD>w<CR>", "Save file" },
        x = { "<CMD>x<CR>", "Save and quit" },

        b = {
            name = "Buffer",
            d = { "<CMD>BufferDelete<CR>", "Delete buffer" },
            D = { "<CMD>BufferWipeout<CR>", "Wipe buffer" },
            p = { "<CMD>BufferPin<CR>", "Pin buffer" },
            b = { "<CMD>BufferPick<CR>", "Pick buffer" },
        },

        am = {
            function()
                require("harpoon.mark").add_file()
                vim.notify("marked")
            end,
            "Add file to harpoon marks",
        },

        ca = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code action" },

        rn = { "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename variable" },

        s = {
            name = "Session",
            s = { "<CMD>SessionSave<CR>", "Save session" },
            d = { "<CMD>SessionDelete<CR>", "Delete session" },
        },

        f = {
            name = "Find",
            f = { "<CMD>Telescope find_files prompt_prefix=Files\\ ❯\\ <CR>", "Find files" },
            t = { "<CMD>Telescope live_grep prompt_prefix=Text\\ ❯\\ <CR>", "Find text" },
            r = { "<CMD>Telescope oldfiles prompt_prefix=Recent\\ Files\\ ❯\\ <CR>", "Find recent files" },
            d = { "<CMD>Telescope diagnostics prompt_prefix=Diagnostics\\ ❯\\ <CR>", "Find workspace diagnostics" },
            s = { "<CMD>Telescope aerial prompt_prefix=Symbols\\ ❯\\ <CR>", "Find buffer symbols" },
            b = { "<CMD>Telescope buffers prompt_prefix=Buffers\\ ❯\\ <CR>", "Find buffers" },
            p = { "<CMD>Telescope projects prompt_prefix=Projects\\ ❯\\ <CR>", "Find projects" },
            k = { "<CMD>Telescope keymaps prompt_prefix=Keybinds\\ ❯\\ <CR>", "Find keymaps" },
            y = { "<CMD>Telescope neoclip prompt_prefix=Yanks\\ ❯\\ <CR>", "Find yanks" },
            n = { "<CMD>Telescope notify prompt_prefix=Notifications\\ ❯\\ <CR>", "Find notifications" },
            S = { "<CMD>Telescope persisted prompt_prefix=Sessions\\ ❯\\ <CR>", "Find sessions" },
            m = { "<CMD>Telescope harpoon marks prompt_prefix=Marks\\ ❯\\ <CR>", "Find harpoon marks" },
            ["'"] = { "<CMD>Telescope marks prompt_prefix=Marks\\ ❯\\ <CR>", "Find marks" },
            u = { "<CMD>Telescope undo prompt_prefix=Undo\\ ❯\\ <CR>", "Find undos" },
        },

        g = {
            name = "Git",
            s = { "<CMD>Telescope git_status prompt_prefix=Git\\ status\\ ❯\\ <CR>", "Git status" },
            b = { "<CMD>Telescope git_branches prompt_prefix=Git\\ branches\\ ❯\\ <CR>", "Git branches" },
            c = { "<CMD>Telescope conventional_commits theme=dropdown<CR>", "Git commits" },
        },
    },

    ["]"] = {
        name = "Next",
        b = { "<CMD>BufferNext<CR>", "Next buffer" },
        t = { "<CMD>tabnext<CR>", "Next tab" },
        g = { "<CMD>Gitsigns next_hunk<CR>", "Next git hunk" },
        d = { "<CMD>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic" },
        m = { "<CMD>lua require('harpoon.ui').nav_next()<CR>", "Go to next harpooned file" },
    },

    ["["] = {
        name = "Previous",
        b = { "<CMD>BufferPrevious<CR>", "Previous buffer" },
        t = { "<CMD>tabprev<CR>", "Previous tab" },
        g = { "<CMD>Gitsigns prev_hunk<CR>", "Previous git hunk" },
        d = { "<CMD>lua vim.diagnostic.goto_prev()<CR>", "Go to previous diagnostic" },
        m = { "<CMD>lua require('harpoon.ui').nav_prev()<CR>", "Go to previous harpooned file" },
    },

    g = {
        c = {
            name = "Comment",
            h = {
                function()
                    local comment = vim.fn.input("Comment: ", "")
                    vim.cmd([[norm! O<ESC>]])
                    local row = vim.api.nvim_win_get_cursor(0)[1]
                    vim.api.nvim_buf_set_lines(0, row - 1, row, false, { comment })
                    require("comment-box").llbox()
                end,
                "Comment headers",
            },
        },
        d = { "<CMD>Telescope lsp_definitions prompt_prefix=Definitions\\ ❯\\ <CR>", "Go to definition" },
        r = { "<CMD>Telescope lsp_references prompt_prefix=References\\ ❯\\ <CR>", "Go to references" },
    },

    z = {
        name = "Folds",
        R = {
            function()
                require("ufo").openAllFolds()
            end,
            "Open all folds",
        },
        M = {
            function()
                require("ufo").closeAllFolds()
            end,
            "Close all folds",
        },
    },

    s = {
        function()
            require("flash").jump({
                search = { forward = true, wrap = false, multi_window = false },
            })
        end,
        "Search forwards",
    },

    S = {
        function()
            require("flash").jump({
                search = { forward = false, wrap = false, multi_window = false },
            })
        end,
        "Search backwards",
    },
})
