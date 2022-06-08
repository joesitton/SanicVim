require("scrollbar").setup({
    set_highlights = false,
    excluded_buftypes = {
        "terminal",
    },
    excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "NvimTree",
        "Floaterm",
        "neo-tree",
        "packer",
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
    },
})

require("scrollbar.handlers.search").setup()
