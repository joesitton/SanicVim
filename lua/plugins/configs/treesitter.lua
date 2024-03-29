vim.g.matchup_matchparen_offscreen = {
    ["method"] = "popup",
    ["highlight"] = "TreesitterContext",
    ["fullwidth"] = 1,
}

vim.g.skip_ts_context_commentstring_module = true

require("ts_context_commentstring").setup({})

require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    ignore_install = { "yaml", "latex", "toml", "phpdoc", "sql" },
    sync_install = false,
    highlight = {
        enable = true,
        disable = function(lang, bufnr)
            return vim.api.nvim_buf_line_count(bufnr) > 20000
        end
    },
    indent = {
        enable = false,
    },
    matchup = {
        enable = true,
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
