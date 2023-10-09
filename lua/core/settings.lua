local g = vim.g
local o = vim.opt
local fn = vim.fn

-- Leader key
g.mapleader = " "
g.localmapleader = " "

-- Syntax highlight ranges
o.synmaxcol = 500
o.colorcolumn = ""

-- Clipboard
o.clipboard = "unnamedplus"

-- Undo
o.undofile = true
o.undolevels = 2000
o.undodir = fn.stdpath("data") .. "/undo"

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
o.signcolumn = "yes:3"
o.cursorline = true

-- Scrolloffs
o.scrolloff = 12
o.sidescrolloff = 24

-- Searching
o.smartcase = true
o.ignorecase = true
o.hlsearch = true
o.incsearch = true
o.joinspaces = true

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
o.splitkeep = "screen"

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
o.fillchars = "diff:╱,foldopen:,foldclose:,eob: ,foldsep: ,stl: ,stlnc: ,vert:▏,vertleft:▏,vertright:▏,horizdown:─,horizup:─"

-- Completion
o.completeopt = "menu,menuone,noselect"
o.pumblend = 0
o.pumheight = 25

-- Statusline
o.cmdheight = 1
o.showmode = false
o.laststatus = 3

-- Backups
o.backup = false
o.writebackup = false

-- Session
o.sessionoptions = "buffers,curdir,folds,winpos,winsize,tabpages,globals"

-- GUI
o.guicursor = "n-v-o:block,c-i-ci-ve-sm:ver25,r-cr:hor25"
o.guifont = "Iosevka Custom:h18"

-- Other
o.autowrite = true
o.termguicolors = true
o.title = false
o.hidden = true
o.mouse = "a"
o.autoread = true
o.linebreak = true
o.lazyredraw = false
o.wrap = false
o.ruler = false
o.shortmess:append({ W = true, I = true, c = true, C = true })
o.whichwrap:append("<>[]hl")
o.iskeyword:remove({ "_" })
o.mousescroll = "ver:3,hor:4"
o.conceallevel = 3
o.confirm = true
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep"
o.inccommand = "split"

-- Virtualenv
g.python3_host_prog = "~/.pyenv/versions/neovim/bin/python"

-- Signs
fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
fn.sign_define("DapStopped", { text = "", texthl = "DapStopped" })
fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpointCondition" })
fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpointRejected" })
fn.sign_define("DapLogPoint", { text = ".>", texthl = "DapLogPoint" })
