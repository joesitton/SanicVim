local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
    os.date("%A, %b %-d %Y at %-I:%M %p (%Z)"),
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button("SPC f f", "  Find file", ":Telescope fd<CR>"),
    dashboard.button("SPC f r", "  Find recent", ":Telescope oldfiles<CR>"),
    dashboard.button("SPC f t", "  Find text", ":Telescope live_grep<CR>"),
    dashboard.button("SPC f p", "  Find project", ":Telescope projects<CR>"),
    dashboard.button("SPC f m", "  Find marks", ":Telescope marks<CR>"),
    dashboard.button("e", "  New file", ":ene<CR>"),
    -- dashboard.button("u", "  Update plugins", ":PackerSync<CR>"),
    dashboard.button("q", "  Quit", ":qa<CR>"),
}

-- Set footer
dashboard.section.footer.val = {
    " / __ \\ \\__/ / __ \\ \\__/ / __ \\ \\__/ / __ \\ \\__/ / __ \\ \\__/ / __ \\ \\_",
    "/ /  \\ \\____/ /  \\ \\____/ /  \\ \\____/ /  \\ \\____/ /  \\ \\____/ /  \\ \\__",
    "\\ \\__/ / __ \\ \\__/ / __ \\ \\__/ / __ \\ \\__/ / __ \\ \\__/ / __ \\ \\__/ / _",
    " \\____/ /  \\ \\____/ /  \\ \\____/ /  \\ \\____/ /  \\ \\____/ /  \\ \\____/ / ",
    " / __ \\ \\__/ / __ \\ \\__/ / __ \\ \\__/ / __ \\ \\__/ / __ \\ \\__/ / __ \\ \\_",
    "/ /  \\ \\____/ /  \\ \\____/ /  \\ \\____/ /  \\ \\____/ /  \\ \\____/ /  \\ \\__",
}

-- local num_plugins_loaded = #vim.fn.globpath(vim.fn.stdpath("data") .. "/site/pack/packer/start", "*", 0, 1)
-- local num_plugins_tot = #vim.tbl_keys(packer_plugins)

-- local plugins_text = "plugins"
-- if num_plugins_tot <= 1 then
--     plugins_text = "plugin"
-- end

-- dashboard.section.footer.val = {
--     "ﮣ " .. num_plugins_loaded .. " / " .. num_plugins_tot .. " " .. plugins_text .. " loaded",
-- }

dashboard.section.footer.opts.hl = "Comment"

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

-- Do not show statusline or tabline in alpha buffer
-- vim.cmd(
--     [[ au User AlphaReady if winnr('$') == 1 | set laststatus=0 showtabline=0 | endif | au BufUnload <buffer> set laststatus=3 showtabline=2 ]]
-- )

-- Send config to alpha
alpha.setup(dashboard.opts)
