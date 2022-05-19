local g = vim.g
local o = vim.opt

-- Leader key
g.mapleader = " "

-- Use filetypes.lua
g.did_load_filetypes = 0
g.do_filetype_lua = 1

-- Syntax highlight ranges
o.synmaxcol = 500
o.colorcolumn = "99999"

-- Clipboard
o.clipboard = "unnamedplus"

-- Undo
o.undofile = true
o.undodir = vim.fn.stdpath("data") .. "/undo"

-- Indent
o.autoindent = true
o.smartindent = true
o.breakindent = true
o.expandtab = true
o.smarttab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 2

-- Number lines
o.number = true
o.numberwidth = 4
o.relativenumber = true
o.signcolumn = "yes"
o.cursorline = true

-- Scrolloffs
o.scrolloff = 6
o.sidescrolloff = 12

-- Searching
o.smartcase = true
o.ignorecase = true
o.hlsearch = false
o.incsearch = true

-- Timeouts
o.updatetime = 100
o.timeout = true
o.timeoutlen = 500
o.ttimeout = true
o.ttimeoutlen = 0

-- Tabline
o.showtabline = 2

-- Splits
o.splitright = true
o.splitbelow = true

-- Wild menu
o.wildignorecase = true
o.wildmode = "list:longest,full"

-- Folds
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevelstart = 999

-- Characters
o.fillchars = "diff:╱,foldopen:,foldclose:,eob: "

-- Completion
o.completeopt = "menu,menuone,noselect"
o.pumheight = 12

-- Statusline
o.cmdheight = 1
o.showmode = false

-- Backups
o.backup = false
o.writebackup = false

-- Session
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- GUI
o.guicursor = "n-v-o:block,c-i-ci-ve-sm:ver25,r-cr:hor25"
o.guifont = "Iosevka Custom:h16"

-- Other
o.title = true
o.hidden = true
o.mouse = "a"
o.autoread = true
o.linebreak = true
o.lazyredraw = true
o.wrap = false
o.shortmess:append("sI")
o.whichwrap:append("<>[]hl")

-- Virtualenv
g.python3_host_prog = "/usr/share/nvim/venv/bin/python3"

-- Neovide
g.neovide_transparency = 0.9
g.neovide_remember_window_size = true
