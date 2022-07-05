vim.g.matchup_matchparen_offscreen = {
    ["method"] = "popup",
    ["highlight"] = "OffscreenPopup",
    ["fullwidth"] = 1,
}

require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    ignore_install = { "yaml", "latex", "toml", "phpdoc" },
    highlight = {
        enable = true,
    },
    matchup = {
        enable = true,
    },
    autopairs = {
        enable = true,
    },
    rainbow = {
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
            },
        },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gss",
            node_incremental = "gsi",
            -- scope_incremental = "",
            node_decremental = "gsd",
        },
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
})

local ft_to_lang = require("nvim-treesitter.parsers").ft_to_lang

require("nvim-treesitter.parsers").ft_to_lang = function(ft)
    if ft == "zsh" then
        return "bash"
    end

    return ft_to_lang(ft)
end
