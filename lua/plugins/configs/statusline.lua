local base16 = require("lualine.themes.base16")

local diffviewfiles_extension = {
    sections = { lualine_b = { "filetype" } },
    inactive_sections = { lualine_b = { "filetype" } },
    filetypes = { "DiffviewFiles" },
}

local diffviewhistory_extension = {
    sections = { lualine_b = { "filetype" } },
    inactive_sections = { lualine_b = { "filetype" } },
    filetypes = { "DiffviewFileHistory" },
}

local neotree_extension = {
    sections = { lualine_b = {
        function()
            return "Files"
        end,
    } },
    inactive_sections = { lualine_b = {
        function()
            return "Files"
        end,
    } },
    filetypes = { "neo-tree" },
}

local telescope_extension = {
    sections = { lualine_b = {
        function()
            return "Telescope"
        end,
    } },
    inactive_sections = { lualine_b = {
        function()
            return "Telescope"
        end,
    } },
    filetypes = { "Telescope", "TelescopePrompt" },
}

require("lualine").setup({
    options = {
        theme = base16,
        always_divide_middle = true,
        globalstatus = true,
        component_separators = { left = "╲", right = "╱" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        disabled_buftypes = { "quickfix", "prompt", "nofile" },
    },
    sections = {
        lualine_a = {
            {
                "mode",
                fmt = function(str)
                    return str:sub(1, 1)
                end,
            },
        },
        lualine_b = {
            {
                "filename",
                path = 1,
                shorting_target = 40,
                symbols = { modified = " ", readonly = " " },
            },
            "filesize",
        },
        lualine_c = { "branch", "diff" },
        lualine_x = {
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = {
                    error = " ",
                    warn = " ",
                    info = " ",
                    hint = " ",
                },
                colored = true,
            },
            -- {
            --   function()
            --     local msg = ""
            --     local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
            --     local clients = vim.lsp.get_active_clients()

            --     if next(clients) == nil then
            --       return msg
            --     end

            --     for _, client in ipairs(clients) do
            --       local filetypes = client.config.filetypes

            --       if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            --         return "🛠  " .. client.name
            --       end
            --     end
            --   end,
            --   cond = function()
            --     return vim.fn.winwidth("%") > 90
            --   end
            -- },
        },
        lualine_y = { "filetype" },
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {
            {
                "filename",
                path = 0,
                shorting_target = 40,
                symbols = { modified = " ", readonly = " " },
            },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    extensions = {
        "nvim-tree",
        "quickfix",
        "toggleterm",
        "fugitive",
        telescope_extension,
        diffviewfiles_extension,
        diffviewhistory_extension,
        neotree_extension,
    },
})
