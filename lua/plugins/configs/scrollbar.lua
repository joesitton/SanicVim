require("scrollbar").setup({
    show_in_active_only = true,
    set_highlights = false,
    hide_if_all_visible = true,
    excluded_buftypes = {
        "terminal",
        "neo-tree",
    },
    excluded_filetypes = {
        "alpha",
        "aerial",
        "prompt",
        "TelescopePrompt",
        "NvimTree",
        "Floaterm",
        "neo-tree",
        "packer",
        "lsp-installer",
    },
    marks = {
        Cursor = { text = "▐" },
        Search = { text = { "▕", "▐" } },
        Error = { text = { "▕", "▐" } },
        Warn = { text = { "▕", "▐" } },
        Info = { text = { "▕", "▐" } },
        Hint = { text = { "▕", "▐" } },
        Misc = { text = { "▕", "▐" } },
        GitAdd = { text = "▕", priority = 7, },
        GitChange = { text = "▕", priority = 7, },
        GitDelete = { text = "▕", priority = 7, },
    },
    handlers = {
        cursor = true,
        search = true,
        diagnostic = true,
        gitsigns = true,
    },
})
