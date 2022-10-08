local colors = require("lush_theme.colors")

colors.fg = colors.white
colors.bg = colors.black
colors.gray = colors.white.darken(20)

for k, v in pairs(colors) do
    colors[k] = v.hex
end

local vi_mode = require("feline.providers.vi_mode")

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
        darker = dim(color, 72),
        even_darker = dim(color, 82),
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
    provider = " ",
    enabled = function()
        return vim.bo.readonly
    end,
    hl = function()
        return {
            fg = colors.orange,
            bg = get_mode_color().darker,
        }
    end,
    left_sep = "block",
    right_sep = {
        str = "slant_right_thin",
        hl = function()
            return {
                fg = get_mode_color().color,
                bg = get_mode_color().darker,
            }
        end,
    },
})

table.insert(components.active[1], {
    provider = function()
        return vim.fn.fnamemodify(vim.fn.getcwd(0), ":~")
    end,
    hl = function()
        return {
            fg = colors.fg,
            bg = get_mode_color().darker,
        }
    end,
    left_sep = "block",
    -- right_sep = "block",
})

-- table.insert(components.active[1], {
--     provider = {
--         name = "file_info",
--         opts = {
--             type = "unique-short",
--             file_modified_icon = "",
--             file_readonly_icon = "🔒 ",
--             colored_icon = true,
--         },
--     },
--     hl = function()
--         return {
--             bg = get_mode_color().darker,
--         }
--     end,
--     left_sep = "block",
--     right_sep = {
--         "block",
--         {
--             str = "slant_right",
--             hl = function()
--                 return {
--                     fg = get_mode_color().darker,
--                     bg = get_mode_color().even_darker,
--                 }
--             end,
--         },
--     },
-- })

table.insert(components.active[1], {
    provider = {
        name = "git_branch",
    },
    hl = function()
        return {
            fg = colors.purple,
            bg = get_mode_color().darker,
        }
    end,
    left_sep = {
        "block",
        {
            str = "slant_right_thin",
            hl = function()
                return {
                    fg = get_mode_color().color,
                    bg = get_mode_color().darker,
                }
            end,
        },
        "block",
    },
    right_sep = {
        "block",
        {
            str = "slant_right_thin",
            hl = function()
                return {
                    fg = get_mode_color().color,
                    bg = get_mode_color().darker,
                }
            end,
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
            bg = get_mode_color().darker,
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
            bg = get_mode_color().darker,
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
            bg = get_mode_color().darker,
        }
    end,
})

table.insert(components.active[1], {
    provider = " ",
    hl = function()
        return {
            bg = get_mode_color().darker,
        }
    end,
    right_sep = {
        str = "slant_right",
        hl = function()
            return {
                fg = get_mode_color().darker,
                bg = get_mode_color().even_darker,
            }
        end,
    },
})

table.insert(components.active[1], {
    provider = {
        name = "diagnostic_errors",
    },
    hl = function()
        return {
            fg = colors.red,
            bg = get_mode_color().even_darker,
        }
    end,
})

table.insert(components.active[1], {
    provider = {
        name = "diagnostic_warnings",
    },
    hl = function()
        return {
            fg = colors.yellow,
            bg = get_mode_color().even_darker,
        }
    end,
})

table.insert(components.active[1], {
    provider = {
        name = "diagnostic_info",
    },
    hl = function()
        return {
            fg = colors.blue,
            bg = get_mode_color().even_darker,
        }
    end,
})

table.insert(components.active[1], {
    provider = {
        name = "diagnostic_hints",
    },
    hl = function()
        return {
            fg = colors.white,
            bg = get_mode_color().even_darker,
        }
    end,
})

-- table.insert(components.active[3], {
--     provider = " ",
--     enabled = function()
--         local severity = vim.diagnostic.severity
--         local diagnostics_exist = require("feline.providers.lsp").diagnostics_exist
--
--         return diagnostics_exist(severity.ERROR)
--             or diagnostics_exist(severity.WARN)
--             or diagnostics_exist(severity.INFO)
--             or diagnostics_exist(severity.HINT)
--     end,
--     hl = function()
--         return {
--             bg = get_mode_color().even_darker,
--         }
--     end,
--     left_sep = {
--         str = "slant_left_thin",
--         hl = function()
--             return {
--                 fg = get_mode_color().color,
--                 bg = get_mode_color().even_darker,
--             }
--         end,
--     },
-- })

-- local luasnip = require("luasnip")

-- table.insert(components.active[3], {
--     provider = " ",
--     enabled = function()
--         return luasnip.expand_or_jumpable()
--     end,
--     hl = function()
--         return {
--             fg = colors.white,
--             bg = get_mode_color().even_darker,
--         }
--     end,
-- })

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
    provider = " ",
    hl = function()
        return {
            fg = get_mode_color().darker,
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
    },
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
    provider = function()
        -- stackoverflow, compute human readable file size
        local suffix = { "b", "k", "M", "G", "T", "P", "E" }
        local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
        fsize = (fsize < 0 and 0) or fsize
        if fsize < 1024 then
            return fsize .. suffix[1]
        end
        local i = math.floor((math.log(fsize) / math.log(1024)))
        return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
    end,
    hl = function()
        return {
            bg = get_mode_color().darker,
        }
    end,
    left_sep = "block",
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

-- table.insert(components.active[3], {
--     provider = function()
--         return require("auto-session-library").current_session_name()
--     end,
--     hl = function()
--         return {
--             bg = get_mode_color().darker,
--         }
--     end,
--     left_sep = {
--         {
--             str = "slant_left_thin",
--             hl = function()
--                 return {
--                     fg = get_mode_color().color,
--                     bg = get_mode_color().darker,
--                 }
--             end,
--         },
--         "block",
--     },
--     right_sep = "block",
-- })

components.inactive = components.active

require("feline").setup({
    theme = colors,
    components = components,
    vi_mode_colors = vi_mode_colors,
})

-- local navic = require("nvim-navic")

-- local winbar_components = {
--     active = { {} },
-- }

-- table.insert(winbar_components.active[1], {
--     provider = function()
--         return navic.get_location({ icons = require("core.utils").symbols, highlight = true, separator = " " })
--     end,
--     enabled = function()
--         return navic.is_available()
--     end,
--     hl = {
--         bg = colors.light_black,
--     },
-- })

-- require("feline").winbar.setup({
--     theme = colors,
--     components = winbar_components,
--     vi_mode_colors = vi_mode_colors,
-- })
