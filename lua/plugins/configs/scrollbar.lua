require("scrollbar").setup({
    set_highlights = false,
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
        Search = { text = { "", "" } },
        Error = { text = { "", "" } },
        Warn = { text = { "", "" } },
        Info = { text = { "", "" } },
        Hint = { text = { "", "" } },
        Misc = { text = { "", "" } },
    },
    handlers = {
        search = true,
        diagnostic = true,
    },
})
