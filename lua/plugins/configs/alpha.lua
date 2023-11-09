local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local fortune = require("alpha.fortune")

-- Set header
dashboard.section.header.val = fortune()

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button("r", "  Restore session", ":silent! SessionRestore<CR>"),
    dashboard.button("SPC f S", "  Find session", ":Telescope session-lens<CR>"),
    -- dashboard.button("SPC f S", "  Find session", "<CMD>Telescope session-lens prompt_prefix=Sessions\\ ❯\\ <CR>"),
    dashboard.button("SPC f f", "  Find file", "<CMD>Telescope find_files prompt_prefix=Files\\ ❯\\ <CR>"),
    dashboard.button("SPC f r", "  Find recent", "<CMD>Telescope oldfiles prompt_prefix=Recent\\ Files\\ ❯\\ <CR>"),
    dashboard.button("SPC f t", "  Find text", "<CMD>Telescope live_grep prompt_prefix=Text\\ ❯\\ <CR>"),
    -- dashboard.button("SPC f p", "  Find project", "<CMD>Telescope projects theme=dropdown prompt_prefix=Files\\ ❯\\ <CR>"),
    dashboard.button("SPC f m", "  Find marks", "<CMD>Telescope harpoon marks prompt_prefix=Marks\\ ❯\\ <CR>"),
    dashboard.button("e", "  New file", ":ene<CR>"),
    dashboard.button("u", "  Update plugins", ":Lazy sync<CR>"),
    dashboard.button("q", "  Quit", ":qa<CR>"),
}

-- Set paddings
local h_header = #dashboard.section.header.val
local h_buttons = #dashboard.section.buttons.val * 2 - 1
local h_footer = #dashboard.section.footer.val
local pad_tot = vim.o.lines - (h_header + h_buttons + h_footer)
local pad_1 = math.ceil(pad_tot * 0.25)
local pad_2 = math.ceil(pad_tot * 0.20)
local pad_3 = math.floor(pad_tot * 0.30)

dashboard.config.layout = {
    { type = "padding", val = pad_1 },
    dashboard.section.header,
    { type = "padding", val = pad_2 },
    dashboard.section.buttons,
    { type = "padding", val = pad_3 },
    dashboard.section.footer,
}

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Do not show statusline or tabline in alpha buffer
vim.cmd(
    "au User AlphaReady if winnr('$') == 1 | set laststatus=0 showtabline=0 | endif | au BufUnload <buffer> set laststatus=3 showtabline=2"
)
