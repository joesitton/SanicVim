local function get_diagnostic_label(props)
    local icons = { error = '', warn = '', info = '', hint = '', }
    local label = {}
    for severity, icon in pairs(icons) do
        local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
        if n > 0 then
            table.insert(label, { icon .. ' ' .. n .. ' ', group = 'DiagnosticSign' .. severity })
        end
    end
    -- if #label > 0 then
    --     table.insert(label, {'| '})
    -- end
    return label
end

local function get_git_diff(props)
    local icons = { removed = "", changed = "", added = "" }
    local labels = {}
    local signs = vim.api.nvim_buf_get_var(props.buf, "gitsigns_status_dict")
    -- local signs = vim.b.gitsigns_status_dict
    for name, icon in pairs(icons) do
        if tonumber(signs[name]) and signs[name] > 0 then
            table.insert(labels, { icon .. " " .. signs[name] .. " ",
            group = "Diff" .. name
        })
        end
    end
    -- if #labels > 0 then
    --   table.insert(labels, { '| ' })
    -- end
    return labels
end

require("incline").setup({
    render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':~')
        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
        local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and "" or ""

        local buffer = {
            -- { get_diagnostic_label(props) },
            -- { get_git_diff(props) },
            -- { ft_icon, guifg = ft_color }, { " " },
            -- { filename, gui = modified },
        }
        return buffer
    end,
    window = {
        placement = {
            -- horizontal = "left",
        },
        margin = {
            horizontal = 0,
            vertical = { top = 0, bottom = 0 }
        },
        padding = 0,
    }
})
