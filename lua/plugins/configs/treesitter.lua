vim.g.matchup_matchparen_offscreen = {
    ["method"] = "popup",
    ["highlight"] = "OffscreenPopup",
    ["fullwidth"] = 1,
}

require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    ignore_install = { "yaml", "latex", "toml", "phpdoc" },
    highlight = { enable = true },
    context_commentstring = { enable = true, enable_autocmd = false },
    matchup = { enable = true },
    autopairs = { enable = true },
    rainbow = { enable = true },
    textobjects = { enable = true },
    incremental_selection = { enable = true, keymaps = {} },
})

local ft_to_lang = require("nvim-treesitter.parsers").ft_to_lang

require("nvim-treesitter.parsers").ft_to_lang = function(ft)
    if ft == "zsh" then
        return "bash"
    end

    return ft_to_lang(ft)
end
