local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local o = vim.opt
local ol = vim.opt_local
-- local fn = vim.fn
local cmd = vim.cmd
-- local api = vim.api

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime", {}),
    command = "checktime",
})

autocmd("FileType", {
    group = augroup("close_with_q", {}),
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "checkhealth",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

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

autocmd({ "BufWritePre" }, {
    group = augroup("auto_create_dir", {}),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})
