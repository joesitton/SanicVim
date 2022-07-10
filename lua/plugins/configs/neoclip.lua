require("neoclip").setup({
    default_register = "+",
    enable_persistent_history = true,
    keys = {
        telescope = {
            i = {
                select = "<CR>",
                paste = "<C-_>", -- ignore
                paste_behind = "<C-_>", -- ignore
                replay = "<C-r>",
                delete = "<C-d>",
                custom = {},
            },
            n = {
                select = "<cr>",
                paste = "p",
                paste_behind = "P",
                replay = "q",
                delete = "d",
                custom = {},
            },
        },
    },
})
