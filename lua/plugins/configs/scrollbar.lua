-- require("scrollbar.handlers").register("git", function()
--     local handle = io.popen("git diff " .. vim.fn.expand("%") .. " | grep -E '^@@' | awk '{print $3}' | paste -sd:")
--     local signs = {}

--     if handle then
--         local git = handle:read()

--         for line in git:gmatch("[^:]+") do
--             local line = line:sub(2, #line)
--             local positions = {}

--             for position in line:gmatch("[^,]+") do
--                 table.insert(positions, position)
--             end

--             for i = positions[1], positions[2] do
--                 table.insert(signs, {
--                     line = i,
--                     type = "GitAdd",
--                 })
--             end
--         end
--     end

--     return signs
-- end)

require("scrollbar").setup({
    set_highlights = false,
    excluded_buftypes = {
        "terminal",
        "neo-tree",
    },
    excluded_filetypes = {
        "alpha",
        "aerial",
        "prompt",
        "TelescopePrompt",
        "NvimTree",
        "Floaterm",
        "neo-tree",
        "packer",
        "lsp-installer",
    },
    marks = {
        Search = { text = { "", "" } },
        Error = { text = { "", "" } },
        Warn = { text = { "", "" } },
        Info = { text = { "", "" } },
        Hint = { text = { "", "" } },
        Misc = { text = { "", "" } },
        -- GitAdd = { text = { "", "" }, priority = 5 },
    },
    handlers = {
        search = false,
        diagnostic = true,
    },
})
