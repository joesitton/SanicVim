require("focus").setup({
    signcolumn = false,
    cursorline = false,
    excluded_buftypes = {
        "help",
        "nowrite",
        "prompt",
        "popup",
    },
    excluded_filetypes = {
        "help",
        "NvimTree_*",
        "neo-tree",
        "Telescope",
        "TelescopePrompt",
        "ToggleTerm",
        "DiffviewFiles",
        "DiffviewFileHistory",
        "fugitive",
        "DressingInput",
    },
})
