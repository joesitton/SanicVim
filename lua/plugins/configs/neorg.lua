require("neorg").setup({
    load = {
        ["core.defaults"] = {},
        ["core.keybinds"] = {
            config = {
                default_keybinds = false,
            },
        },
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        ["core.norg.concealer"] = {},
        ["core.integrations.nvim-cmp"] = {},
    },
})
