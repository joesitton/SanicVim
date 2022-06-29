local vi_mode = require("feline.providers.vi_mode")
local colors = require("lush_theme.colors")

for k, v in pairs(colors) do
    colors[k] = v.hex
end

local components = {
    active = { {}, {}, {} },
}

table.insert(components.active[1], {
    provider = function()
        return vi_mode.get_vim_mode()
    end,
    hl = function()
        return {
            bg = vi_mode.get_mode_color(),
            fg = colors.black,
            style = "bold",
        }
    end,
    left_sep = "block",
    right_sep = { "right_rounded", " " },
})

table.insert(components.active[1], {
    provider = {
        name = "file_info",
        opts = {
            type = "unique",
            file_modified_icon = "•",
            file_readonly_icon = " ",
            colored_icon = false,
        },
    },
    hl = function()
        return {
            bg = colors.purple,
            fg = colors.black,
        }
    end,
    left_sep = {
        {
            str = "left_rounded",
            hl = {
                fg = colors.purple,
            },
        },
    },
    right_sep = {
        {
            str = "right_rounded",
            hl = {
                fg = colors.purple,
                bg = colors.dark_purple,
            },
        },
    },
})

table.insert(components.active[1], {
    provider = {
        name = "file_size",
    },
    hl = function()
        return {
            fg = colors.white,
            bg = colors.dark_purple,
        }
    end,
    left_sep = {
        str = " ",
        hl = {
            bg = colors.dark_purple,
        },
    },
    right_sep = {
        {
            str = "right_rounded",
            hl = {
                fg = colors.dark_purple,
            },
        },
        " ",
    },
})

table.insert(components.active[1], {
    provider = {
        name = "git_branch",
    },
    hl = function()
        return {
            bg = colors.blue,
            fg = colors.black,
        }
    end,
    left_sep = "left_rounded",
    right_sep = {
        {
            str = "right_rounded",
            hl = {
                fg = colors.blue,
                bg = colors.dark_blue,
            },
        },
    },
})

table.insert(components.active[1], {
    provider = {
        name = "git_diff_added",
    },
    hl = function()
        return {
            fg = colors.green,
            bg = colors.dark_blue,
        }
    end,
})

table.insert(components.active[1], {
    provider = {
        name = "git_diff_removed",
    },
    hl = function()
        return {
            fg = colors.red,
            bg = colors.dark_blue,
        }
    end,
})

table.insert(components.active[1], {
    provider = {
        name = "git_diff_changed",
    },
    hl = function()
        return {
            fg = colors.blue,
            bg = colors.dark_blue,
        }
    end,
})

table.insert(components.active[1], {
    provider = " ",
    left_sep = {
        {
            str = "right_rounded",
            hl = {
                fg = colors.dark_blue,
            },
        },
    },
})

table.insert(components.active[3], {
    provider = " ",
    right_sep = {
        {
            str = "left_rounded",
            hl = {
                fg = colors.dark_orange,
            },
        },
    },
})

table.insert(components.active[3], {
    provider = {
        name = "diagnostic_errors",
    },
    hl = function()
        return {
            fg = colors.red,
            bg = colors.dark_orange,
        }
    end,
})

table.insert(components.active[3], {
    provider = {
        name = "diagnostic_warnings",
    },
    hl = function()
        return {
            fg = colors.yellow,
            bg = colors.dark_orange,
        }
    end,
})

table.insert(components.active[3], {
    provider = {
        name = "diagnostic_info",
    },
    hl = function()
        return {
            fg = colors.white,
            bg = colors.dark_orange,
        }
    end,
})

table.insert(components.active[3], {
    provider = {
        name = "diagnostic_hints",
    },
    hl = function()
        return {
            fg = colors.blue,
            bg = colors.dark_orange,
        }
    end,
    right_sep = "block",
})

table.insert(components.active[3], {
    provider = {
        name = "lsp_client_names",
    },
    hl = function()
        return {
            fg = colors.black,
            bg = colors.orange,
        }
    end,
    left_sep = {
        {
            str = "left_rounded",
            hl = {
                fg = colors.orange,
                bg = colors.dark_orange,
            },
        },
    },
    right_sep = "block",
})

components.inactive = components.active

require("feline").setup({
    theme = colors,
    components = components,
})
