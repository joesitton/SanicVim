local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local o = vim.opt
local ol = vim.opt_local
local cmd = vim.cmd

-- Check if we need to refresh
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime", {}),
    command = "checktime",
})

-- Close with q
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

-- Help split right
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

-- Buffer focus stuff
autocmd({ "BufWinEnter", "BufEnter", "InsertEnter" }, {
    group = augroup("no_repeat_comments", {}),
    pattern = "*",
    callback = function()
        ol.formatoptions:remove({ "c", "r", "o" })
        cmd([[noh]])
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

-- Auto create dirs on write
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

-- Fix mouse on focus
autocmd({ "FocusGained" }, {
    group = augroup("focus_enable_mouse", {}),
    pattern = "*",
    callback = function ()
        o.mouse = "a"
    end
})
autocmd({ "FocusLost" }, {
    group = augroup("unfocus_disable_mouse", {}),
    pattern = "*",
    callback = function ()
        o.mouse = nil
    end
})

-- Barbecue
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

-- Auto close nvimtree
autocmd({ "BufEnter" }, {
    group = augroup("nvim_tree_close", {}),
    pattern = "NvimTree_*",
    callback = function()
        local layout = vim.api.nvim_call_function("winlayout", {})
        if
            layout[1] == "leaf"
            and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
            and layout[3] == nil
        then
            vim.cmd("confirm quit")
        end
    end,
})

-- Format gocode on save
autocmd({ "BufWritePre" }, {
    group = augroup("format_gocode", {}),
    pattern = "*.go",
    callback = function()
        require("go.format").goimport()
    end
})

autocmd({"User"}, {
    group = augroup("session_pre_save", {}),
    pattern = "PersistedSavePre",
    callback = function ()
        local ok, _ = pcall(require, "diffview")
        if ok then
            vim.cmd("DiffviewClose")
        end
    end
})
