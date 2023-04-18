local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local o = vim.opt
local ol = vim.opt_local
-- local fn = vim.fn
local cmd = vim.cmd
-- local api = vim.api

-- Buffer focus stuff
autocmd({ "BufWinEnter", "BufEnter", "InsertEnter" }, {
    group = augroup("no_repeat_comments", {}),
    pattern = "*",
    callback = function()
        ol.formatoptions:remove({ "c", "r", "o" })
        cmd([[noh]])
    end,
})

-- Vertical split for help
autocmd("BufEnter", {
    group = augroup("vertical_split_help", {}),
    pattern = "*.txt",
    callback = function()
        if vim.bo.buftype == "help" then
            ol.signcolumn = "no"
            ol.colorcolumn = "0"
            cmd([[ silent! wincmd L ]])
        end
    end,
})

-- Yank highlight
autocmd("TextYankPost", {
    group = augroup("yank_highlight", {}),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 420 })
    end,
})

-- Auto spellcheck
autocmd("FileType", {
    group = augroup("auto_spellcheck", {}),
    pattern = { "gitcommit", "markdown", "text" },
    callback = function()
        ol.spell = true
    end,
})

-- Auto close aerial
-- autocmd("BufWinLeave", {
--     group = augroup("auto_close_aerial", {}),
--     pattern = "*",
--     callback = function()
--         if vim.fn.expand("<afile>"):match("aerial") then
--             cmd([[AerialClose]])
--         end
--     end,
-- })

autocmd("VimEnter", {
    group = augroup("illuminate_highlight", {}),
    pattern = "*",
    callback = function()
        cmd([[
            hi! link illuminatedWord IlluminatedWordText
        ]])
    end,
})

autocmd({ "WinScrolled", "BufWinEnter", "CursorHold", "InsertLeave", "BufWritePost", "TextChanged", "TextChangedI" }, {
    group = augroup("barbecue#create_autocmd", {}),
    pattern = "*",
    callback = function()
        local ok, barbecue = pcall(require, "barbecue.ui")

        if ok then
            barbecue.update()
        end
    end,
})

-- autocmd("User", {
--     group = augroup("persisted_telescope_load_pre", {}),
--     pattern = "PersistedSavePre",
--     callback = function()
--         vim.api.nvim_input("<ESC>:%bd<CR>")
--     end,
-- })

-- autocmd({"TextChangedI", "TextChangedP"}, {
--     pattern = "*",
--     callback = function()
--         local line = vim.api.nvim_get_current_line()
--         local cursor = vim.api.nvim_win_get_cursor(0)[2]

--         local current = string.sub(line, cursor, cursor + 1)
--         if current == "." or current == "," or current == " " then
--             require('cmp').close()
--         end

--         local before_line = string.sub(line, 1, cursor + 1)
--         local after_line = string.sub(line, cursor + 1, -1)
--         if not string.match(before_line, '^%s+$') then
--             if after_line == "" or string.match(before_line, " $") or string.match(before_line, "%.$") then
--                 require('cmp').complete()
--             end
--         end
--     end,
-- })
