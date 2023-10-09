vim.g.matchup_matchparen_offscreen = {
    ["method"] = "popup",
    ["highlight"] = "TreesitterContext",
    ["fullwidth"] = 1,
}

require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    ignore_install = { "yaml", "latex", "toml", "phpdoc" },
    sync_install = false,
    highlight = {
        enable = true,
    },
    indent = {
        enable = false,
    },
    matchup = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false, -- configured in configs.comments pre_hook
    },
    textobjects = {
        enable = true,
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["ac"] = "@conditional.outer",
                ["ic"] = "@conditional.inner",
                ["as"] = "@statement.outer",
                ["is"] = "@statement.inner",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["]a"] = "@parameter.inner",
            },
            swap_previous = {
                ["[a"] = "@parameter.inner",
            },
        },
    },
})
