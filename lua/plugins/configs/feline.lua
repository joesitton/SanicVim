local colors = require("lush_theme.colors")

colors.fg = colors.white
colors.bg = colors.black
colors.gray = colors.white.darken(20)

for k, v in pairs(colors) do
    colors[k] = v.hex
end

local feline = require("feline")
local vi_mode = require("feline.providers.vi_mode")
local navic = require("nvim-navic")

local vi_mode_colors = {
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
}

local function get_mode_color()
    local function dim(color, percent)
        return require("lush").hsl(color).darken(percent).desaturate(50).hex
    end

    local color = vi_mode_colors[vi_mode.get_vim_mode()]

    return {
        color = color,
        darker = dim(color, 75),
        even_darker = dim(color, 85),
    }
end

local components = {
    active = { {}, {}, {} },
}

table.insert(components.active[1], {
    provider = " ",
    hl = function()
        return {
            bg = vi_mode.get_mode_color(),
        }
    end,
})

table.insert(components.active[1], {
    provider = {
        name = "file_info",
        opts = {
            type = "unique-short",
            file_modified_icon = "",
            file_readonly_icon = "🔒 ",
            colored_icon = true,
        },
    },
    hl = function()
        return {
            bg = get_mode_color().darker,
        }
    end,
    left_sep = "block",
    right_sep = {
        "block",
        {
            str = "slant_right",
            hl = function()
                return {
                    fg = get_mode_color().darker,
                    bg = get_mode_color().even_darker,
                }
            end,
        },
    },
})

table.insert(components.active[1], {
    provider = {
        name = "git_branch",
    },
    hl = function()
        return {
            fg = colors.purple,
            bg = get_mode_color().even_darker,
        }
    end,
    left_sep = "block",
    right_sep = "block",
})

table.insert(components.active[1], {
    provider = {
        name = "git_diff_added",
    },
    hl = function()
        return {
            fg = colors.green,
            bg = get_mode_color().even_darker,
        }
    end,
    right_sep = "block",
})

table.insert(components.active[1], {
    provider = {
        name = "git_diff_removed",
    },
    hl = function()
        return {
            fg = colors.red,
            bg = get_mode_color().even_darker,
        }
    end,
    right_sep = "block",
})

table.insert(components.active[1], {
    provider = {
        name = "git_diff_changed",
    },
    hl = function()
        return {
            fg = colors.blue,
            bg = get_mode_color().even_darker,
        }
    end,
    -- NOTE: no right_sep so the background fills
})

-- Right side

table.insert(components.active[3], {
    provider = {
        name = "diagnostic_errors",
    },
    hl = function()
        return {
            fg = colors.red,
            bg = get_mode_color().even_darker,
        }
    end,
    right_sep = "block",
})

table.insert(components.active[3], {
    provider = {
        name = "diagnostic_warnings",
    },
    hl = function()
        return {
            fg = colors.yellow,
            bg = get_mode_color().even_darker,
        }
    end,
    right_sep = "block",
})

table.insert(components.active[3], {
    provider = {
        name = "diagnostic_info",
    },
    hl = function()
        return {
            fg = colors.blue,
            bg = get_mode_color().even_darker,
        }
    end,
    right_sep = "block",
})

table.insert(components.active[3], {
    provider = {
        name = "diagnostic_hints",
    },
    hl = function()
        return {
            fg = colors.white,
            bg = get_mode_color().even_darker,
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
            fg = colors.gray,
            bg = get_mode_color().even_darker,
        }
    end,
    right_sep = "block",
})

table.insert(components.active[3], {
    provider = {
        name = "file_type",
        opts = {
            case = "lowercase",
        },
    },
    hl = function()
        return {
            bg = get_mode_color().darker,
        }
    end,
    left_sep = {
        {
            str = "slant_left",
            hl = function()
                return {
                    fg = get_mode_color().darker,
                    bg = get_mode_color().even_darker,
                }
            end,
        },
        "block",
    },
    right_sep = "block",
})

-- table.insert(components.active[3], {
--     provider = "file_encoding",
--     hl = function()
--         return {
--             bg = get_mode_color().darker,
--         }
--     end,
--     left_sep = { "block" },
--     right_sep = {
--         "block",
--     },
-- })

table.insert(components.active[3], {
    provider = function()
        return "  " .. vim.o.shiftwidth
    end,
    hl = function()
        return {
            bg = get_mode_color().darker,
        }
    end,
    left_sep = { "block" },
    right_sep = {
        "block",
        {
            str = "slant_left_thin",
            hl = function()
                return {
                    fg = get_mode_color().color,
                    bg = get_mode_color().darker,
                }
            end,
        },
    },
})

table.insert(components.active[3], {
    provider = "position",
    hl = function()
        return {
            bg = get_mode_color().darker,
        }
    end,
    left_sep = "block",
    right_sep = "block",
})

components.inactive = components.active

feline.setup({
    theme = colors,
    components = components,
    vi_mode_colors = vi_mode_colors,
})

if vim.fn.has("nvim-0.8") then
    feline.winbar.setup({
        force_inactive = {"alpha", "help"},
        components = {
            active = {
                {{
                    provider = function()
                        return navic.get_location({
                            icons = require("core.symbols"),
                            highlight = true,
                            separator = "  ",
                        })
                    end,
                }},
            },
            inactive = {}
        },
    })
end
