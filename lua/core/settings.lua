local g = vim.g
local o = vim.opt

-- Leader key
g.mapleader = " "

-- Syntax highlight ranges
o.synmaxcol = 500
o.colorcolumn = "100"

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
o.relativenumber = false
o.signcolumn = "yes:2"
o.cursorline = true

-- Scrolloffs
o.scrolloff = 6
o.sidescrolloff = 64

-- Searching
o.smartcase = true
o.ignorecase = true
o.hlsearch = true
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
-- o.splitkeep = "screen"

-- Wild menu
o.wildignorecase = true
o.wildmode = "list:longest,full"

-- Folds
o.foldenable = true
o.foldcolumn = "0"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"

-- Characters
o.fillchars = "diff:╱,foldopen:,foldclose:,eob: ,vert: ,horiz: ,foldsep: "

-- Completion
o.completeopt = "menu,menuone,noselect"
o.pumheight = 20

-- Statusline
o.cmdheight = 1
o.showmode = false
o.laststatus = 3

-- Backups
o.backup = false
o.writebackup = false

-- Session
o.sessionoptions = "buffers,curdir,folds,winpos,winsize"

-- GUI
o.guicursor = "n-v-o:block,c-i-ci-ve-sm:ver25,r-cr:hor25"
o.guifont = "Iosevka Custom:h18"

-- Other
o.termguicolors = true
o.title = false
o.hidden = true
o.mouse = "a"
o.autoread = true
o.linebreak = true
o.lazyredraw = false
o.wrap = false
o.ruler = false
o.shortmess:append("sI")
o.whichwrap:append("<>[]hl")
o.iskeyword:remove({ "_" })
o.mousescroll = "ver:3,hor:4"

-- Virtualenv
g.python3_host_prog = "/opt/homebrew/opt/python/libexec/bin/python"

-- Neovide
g.neovide_transparency = 0.92
g.neovide_remember_window_size = true

-- Signs
local set_sign = vim.fn.sign_define

set_sign("DiagnosticSignError", { text = "•", texthl = "DiagnosticSignError" })
set_sign("DiagnosticSignWarn", { text = "•", texthl = "DiagnosticSignWarn" })
set_sign("DiagnosticSignInfo", { text = "•", texthl = "DiagnosticSignInfo" })
set_sign("DiagnosticSignHint", { text = "•", texthl = "DiagnosticSignHint" })
