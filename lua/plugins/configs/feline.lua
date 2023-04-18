local colors = require("lush_theme.colors")

colors.fg = colors.white
colors.bg = colors.black.lighten(4)
colors.gray = colors.white.darken(40)
colors.dark_gray = colors.white.darken(50)

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
    SELECT = colors.green,
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

local slant_right_l = {
    {
        str = "slant_right",
        hl = function()
            return {
                fg = get_mode_color().even_darker,
                bg = get_mode_color().darker,
            }
        end,
    },
    "block",
}

local slant_right_r = {
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
}

local slant_left_l = {
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
}

local slant_left_r = {
    "block",
    {
        str = "slant_left",
        hl = function()
            return {
                fg = get_mode_color().even_darker,
                bg = get_mode_color().darker,
            }
        end,
    },
}

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
    provider = function()
        return " "
    end,
    enabled = function()
        return vim.g.persisting == true
    end,
    hl = function()
        return {
            fg = colors.yellow,
            bg = get_mode_color().darker,
        }
    end,
    left_sep = "block"
    -- right_sep = slant_left_r,
})

table.insert(components.active[1], {
    provider = function()
        return vim.fn.fnamemodify(vim.fn.getcwd(0), ":~:.:t") .. "/"
    end,
    icon = {
        str = "  ",
        hl = {
            fg = colors.blue,
        },
    },
    hl = function()
        return {
            fg = colors.gray,
            bg = get_mode_color().darker,
        }
    end,
    left_sep = "block",
    right_sep = slant_right_r,
})

table.insert(components.active[1], {
    provider = "  ",
    enabled = function()
        local excluded_ft = {
            ["neo-tree"] = true,
            ["help"] = true,
        }

        if excluded_ft[vim.bo.filetype] then
            return false
        end

        return vim.bo.readonly
    end,
    hl = function()
        return {
            fg = colors.red,
            bg = get_mode_color().darker,
        }
    end,
    left_sep = slant_right_l,
    right_sep = slant_right_r,
})

table.insert(components.active[1], {
    provider = {
        name = "git_branch",
    },
    hl = function()
        return {
            fg = colors.purple,
            bg = get_mode_color().darker,
            style = "bold",
        }
    end,
    left_sep = slant_right_l,
    right_sep = slant_right_r,
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
})

table.insert(components.active[1], {
    provider = " ",
    hl = function()
        return {
            fg = get_mode_color().even_darker,
            bg = get_mode_color().even_darker,
        }
    end,
})

--------------------------------------------------
--               right-hand side                --
--------------------------------------------------

table.insert(components.active[3], {
    provider = function()
        return "" -- require("noice").api.statusline.mode.get
    end,
    -- enabled = require("noice").api.statusline.mode.has,
    hl = function()
        return {
            fg = colors.orange,
            bg = get_mode_color().even_darker,
        }
    end,
})

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
})

table.insert(components.active[3], {
    provider = " ",
    hl = function()
        return {
            bg = get_mode_color().even_darker,
        }
    end,
})

table.insert(components.active[3], {
    provider = {
        name = "lsp_client_names",
    },
    truncate_hide = true,
    hl = function()
        return {
            fg = colors.gray,
            bg = get_mode_color().darker,
        }
    end,
    left_sep = slant_left_l,
    right_sep = slant_left_r,
})

table.insert(components.active[3], {
    icon = {
        str = " ",
        hl = function()
            return {
                fg = get_mode_color().color,
            }
        end,
    },
    provider = {
        name = "file_type",
        opts = {
            case = "lowercase",
        },
    },
    truncate_hide = true,
    hl = function()
        return {
            bg = get_mode_color().darker,
        }
    end,
    left_sep = slant_left_l,
})

table.insert(components.active[3], {
    provider = function()
        local ok, swenv = pcall(require, "swenv.api")

        if not ok then
            return ""
        end

        local venv = swenv.get_current_venv()

        if not venv then
            return ""
        end

        return "🐍 " .. venv.name
    end,
    enabled = function()
        return vim.bo.filetype == "python"
    end,
    truncate_hide = true,
    hl = function()
        return {
            bg = get_mode_color().darker,
        }
    end,
    left_sep = "block",
    right_sep = slant_left_r,
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
    truncate_hide = true,
    hl = function()
        return {
            bg = get_mode_color().darker,
        }
    end,
    left_sep = "block",
    right_sep = slant_left_r,
})

table.insert(components.active[3], {
    provider = "position",
    hl = function()
        return {
            bg = get_mode_color().darker,
        }
    end,
    left_sep = slant_left_l,
    right_sep = "block",
})

table.insert(components.active[3], {
    provider = "line_percentage",
    hl = function()
        return {
            fg = colors.orange,
            bg = get_mode_color().darker,
            style = "bold",
        }
    end,
    right_sep = "block",
})

table.insert(components.active[3], {
    provider = {
        name = "scroll_bar",
    },
    hl = function()
        return {
            fg = get_mode_color().color,
            bg = get_mode_color().darker,
        }
    end,
    right_sep = "block",
})

components.inactive = components.active

require("feline").setup({
    theme = colors,
    components = components,
    vi_mode_colors = vi_mode_colors,
})
