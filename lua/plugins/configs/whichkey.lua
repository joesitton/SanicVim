local wk = require("which-key")

wk.setup({
    plugins = {
        marks = false,
        registers = false,
        presets = {
            operators = false,
            text_objects = true,
            motions = false,
            windows = false,
            nav = false,
            z = false,
            g = false,
        },
    },
    icons = {
        separator = "  ", -- symbol used between a key and it's label
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
})

local mappings = require("core.mappings")

local modes = {
    n = { mode = "n" },
    v = { mode = "v" },
    x = { mode = "x" },
    o = { mode = "o" },
    i = { mode = "i" },
    t = { mode = "t" },
}

for mode, opt in pairs(modes) do
    for category, value in pairs(mappings) do
        if value[mode] then
            local mode_opts = value["mode_opts"] and vim.tbl_deep_extend("force", opt, value["mode_opts"]) or opt
            mode_opts.name = category
            wk.register(value[mode], mode_opts)
        end
    end
end
