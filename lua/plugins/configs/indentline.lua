require("ibl").setup({
    debounce = 200,
    indent = {
        char = "┃",
    },
    scope = {
        show_start = false,
        show_end = false,
        include = {
            node_type = { ["*"] = { "*" } },
        },
        highlight = {
            "rainbowcol1",
            "rainbowcol7",
            "rainbowcol2",
            "rainbowcol6",
            "rainbowcol3",
            "rainbowcol5",
            "rainbowcol4",
        },
    },
    whitespace = {
        highlight = "NonText",
    },
    exclude = {
        buftypes = { "help", "terminal", "nofile" },
        filetypes = {
            "startify",
            "dashboard",
            "dotooagenda",
            "log",
            "fugitive",
            "gitcommit",
            "packer",
            "vimwiki",
            "markdown",
            "txt",
            "vista",
            "help",
            "todoist",
            "NvimTree",
            "peekaboo",
            "git",
            "TelescopePrompt",
            "undotree",
            "flutterToolsOutline",
            "", -- for all buffers without a file type
        },
    },
})

local hooks = require("ibl.hooks")
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
