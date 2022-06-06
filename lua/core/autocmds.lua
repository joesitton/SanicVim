local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local o = vim.opt
local ol = vim.opt_local
local fn = vim.fn
local cmd = vim.cmd
local api = vim.api

-- Don't repeat comments
autocmd("BufWinEnter", {
    group = augroup("no_repeat_comments", {}),
    pattern = "*",
    callback = function()
        ol.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- Vertical split for help
autocmd("BufEnter", {
    group = augroup("vertical_split_help", {}),
    pattern = "*.txt",
    callback = function()
        if vim.bo.buftype == "help" then
            cmd([[ wincmd L ]])
        end
    end,
})

-- Yank highlight
autocmd("TextYankPost", {
    group = augroup("yank_highlight", {}),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "Search", timeout = 250 })
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
