local colors = require("lush_theme.colors")

for k, v in pairs(colors) do
    colors[k] = v.hex
end

local components = {
    active = { {}, {}, {} },
}

table.insert(components.active[1], {
    provider = " ",
    hl = function()
        return {
            bg = require("feline.providers.vi_mode").get_mode_color(),
            fg = colors.black,
            style = "bold",
        }
    end,
})

table.insert(components.active[1], {
    provider = {
        name = "file_info",
        opts = {
            type = "unique-short",
            file_modified_icon = "•",
            file_readonly_icon = " ",
            colored_icon = true,
        },
    },
    hl = function()
        return {
            bg = colors.bg,
            fg = colors.fg,
        }
    end,
    left_sep = "block",
    right_sep = "block",
})

table.insert(components.active[1], {
    provider = {
        name = "git_branch",
    },
    hl = function()
        return {
            fg = colors.purple,
        }
    end,
    left_sep = {
        {
            str = "right",
            hl = {
                fg = colors.dark_white,
            },
        },
        "block",
    },
    right_sep = {
        "block",
        {
            str = "right",
            hl = {
                fg = colors.dark_white,
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
        }
    end,
})

-- Right side

table.insert(components.active[3], {
    provider = {
        name = "diagnostic_errors",
    },
    -- hl = function()
    --     return {
    --         fg = colors.red,
    --         bg = colors.dark_orange,
    --     }
    -- end,
    right_sep = "block",
})

table.insert(components.active[3], {
    provider = {
        name = "diagnostic_warnings",
    },
    -- hl = function()
    --     return {
    --         fg = colors.yellow,
    --         bg = colors.dark_orange,
    --     }
    -- end,
    right_sep = "block",
})

table.insert(components.active[3], {
    provider = {
        name = "diagnostic_info",
    },
    -- hl = function()
    --     return {
    --         fg = colors.white,
    --         bg = colors.dark_orange,
    --     }
    -- end,
    right_sep = "block",
})

table.insert(components.active[3], {
    provider = {
        name = "diagnostic_hints",
    },
    -- hl = function()
    --     return {
    --         fg = colors.blue,
    --         bg = colors.dark_orange,
    --     }
    -- end,
    right_sep = "block",
})

table.insert(components.active[3], {
    provider = {
        name = "lsp_client_names",
    },
    -- hl = function()
    --     return {
    --         fg = colors.black,
    --         bg = colors.orange,
    --     }
    -- end,
    left_sep = {},
})

table.insert(components.active[3], {
    provider = {
        name = "file_type",
        opts = {
            filetype_icon = true,
            case = "lowercase",
        },
    },
    hl = function()
        return {
            bg = colors.bg,
        }
    end,
    left_sep = {
        {
            str = "left",
            hl = {
                bg = colors.dark_white,
            },
        },
        "block",
    },
    right_sep = "block",
})

components.inactive = components.active

require("feline").setup({
    theme = colors,
    components = components,
    vi_mode_colors = {
        NORMAL = colors.blue,
        OP = colors.purple,
        INSERT = colors.green,
        VISUAL = colors.orange,
        LINES = colors.orange,
        BLOCK = colors.orange,
        REPLACE = colors.red,
        ["V-REPLACE"] = colors.red,
        COMMAND = colors.purple,
        SHELL = colors.green,
        TERM = colors.green,
    },
})
