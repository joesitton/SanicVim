local wk = require("which-key")
local mappings = require("core.mappings")

local modes = {
    n = {
        mode = "n",
    },

    v = {
        mode = "v",
    },

    o = {
        mode = "o",
    },

    i = {
        mode = "i",
    },

    t = {
        mode = "t",
    },
}

for mode, opt in pairs(modes) do
    for _, value in pairs(mappings) do
        if value[mode] then
            local mode_opts = value["mode_opts"] and vim.tbl_deep_extend("force", opt, value["mode_opts"]) or opt
            wk.register(value[mode], mode_opts)
        end
    end
end

wk.setup({
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "  ", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },

    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },

    key_labels = {
        ["<leader>"] = "SPC",
        ["<CR>"] = "RET",
    },

    window = {
        border = "rounded", -- none/single/double/shadow
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    },

    layout = {
        spacing = 8, -- spacing between columns
        align = "center",
    },

    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },

    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        i = { "j", "k" },
        v = { "j", "k" },
    },
})
