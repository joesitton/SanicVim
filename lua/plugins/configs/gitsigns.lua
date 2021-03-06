require("gitsigns").setup({
    preview_config = {
        border = "rounded",
    },
    signs = {
        add = {
            hl = "GitSignsAdd",
            text = "??音",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
        },
        change = {
            hl = "GitSignsChange",
            text = "??音",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
        },
        delete = {
            hl = "GitSignsDelete",
            text = "??音",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
        },
        topdelete = {
            hl = "GitSignsDelete",
            text = "??音",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
        },
        changedelete = {
            hl = "GitSignsChange",
            text = "??音",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
        },
    },
})
