require("neorg").setup({
    load = {
        ["core.defaults"] = {},
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        ["core.norg.concealer"] = {},
        ["core.integrations.nvim-cmp"] = {},
    },
})
