local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local heirline = require("heirline")

local colors = require("lush_theme.colors")
colors.gray = colors.black.lighten(20).hex
colors.gray2 = colors.black.lighten(4).hex
-- heirline.load_colors(colors)

local Align = { provider = "%=" }
local Space = { provider = " " }

local ViMode = {
	update = { "ModeChanged" },
	provider = function(self)
		return "█ " .. vim.fn.mode(1):sub(1, 1)
	end,
	hl = function(self)
		local color = self:mode_color()
		return {
			fg = color,
			bold = true,
		}
	end,
}

local WorkDir = {
	{
		provider = function()
			return (vim.fn.haslocaldir(0) == 1 and "L" or "") .. " " .. "  "
		end,
		hl = {
			fg = colors.blue.hex,
			bold = true,
		},
	},
	{
		init = function(self)
			local cwd = vim.fn.getcwd(0)
			self.cwd = vim.fn.fnamemodify(cwd, ":~")
		end,
		flexible = 1,
		{
			-- evaluates to the full-lenth path
			provider = function(self)
				local trail = self.cwd:sub(-1) == "/" and "" or "/"
				return self.cwd .. trail
			end,
		},
		{
			-- evaluates to the shortened path
			provider = function(self)
				local cwd = vim.fn.pathshorten(self.cwd)
				local trail = self.cwd:sub(-1) == "/" and "" or "/"
				return cwd .. trail
			end,
		},
		hl = {
			fg = colors.white.darken(40).hex,
		},
	},
}

-- WorkDir = utils.surround({ "[", "]" }, nil, WorkDir)

local FileIcon = {
	init = function(self)
		local filename = self.filename
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color =
			require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
		if not self.is_active and not self.is_visible then
			self.icon_color = colors.gray
		end
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return { fg = self.icon_color }
	end,
}

local FileEncoding = {
    provider = function()
        local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
        return enc ~= 'utf-8' and enc:upper()
    end
}

local FileName = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
	provider = function(self)
		-- first, trim the pattern relative to the current directory. For other
		-- options, see :h filename-modifers
		local filename = vim.fn.fnamemodify(self.filename, ":.")
		if filename == "" then
			return "[No Name]"
		end
		-- now, if the filename would occupy more than 1/4th of the available
		-- space, we trim the file path to its initials
		-- See Flexible Components section below for dynamic truncation
		if not conditions.width_percent_below(#filename, 0.25) then
			filename = vim.fn.pathshorten(filename)
		end
		return filename
	end,
	hl = { fg = utils.get_highlight("Directory").fg },
}

local MacroRec = {
	condition = function()
		return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
	end,
	update = {
		"RecordingEnter",
		"RecordingLeave",
	},
	provider = "  ",
	utils.surround({ "[", "]" }, nil, {
		provider = function()
			return vim.fn.reg_recording()
		end,
		hl = {
			fg = colors.green.hex,
			bold = true,
		},
	}),
	hl = {
		fg = colors.orange.hex,
		bold = true,
	},
}

local ReadOnly = {
	condition = function()
		return not vim.bo.modifiable or vim.bo.readonly
	end,
	provider = "  ",
	hl = {
		fg = colors.red.hex,
	},
}

local FileSize = {
	provider = function()
		-- stackoverflow, compute human readable file size
		local suffix = { "b", "k", "M", "G", "T", "P", "E" }
		local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
		fsize = (fsize < 0 and 0) or fsize
		if fsize < 1024 then
			return fsize .. suffix[1]
		end
		local i = math.floor((math.log(fsize) / math.log(1024)))
		return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
	end,
}

local Ruler = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	-- provider = "%7(%l/%3L%):%2c 0x%B %P",
	provider = "%P",
	hl = {
		fg = colors.orange.hex,
	},
}

local FileType = {
	provider = function()
		return string.upper(vim.bo.filetype)
	end,
	hl = {
		fg = utils.get_highlight("Type").fg,
		bold = true,
	},
}

local ScrollBar = {
	static = {
		sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
	},
	provider = function(self)
		local curr_line = vim.api.nvim_win_get_cursor(0)[1]
		local lines = vim.api.nvim_buf_line_count(0)
		local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
		return string.rep(self.sbar[i], 2)
	end,
	hl = {
		fg = colors.blue.hex,
		bg = colors.black.hex,
	},
}

local LSPActive = {
	condition = conditions.lsp_attached,
	update = { "LspAttach", "LspDetach" },
	provider = function()
		local names = {}
		for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		return " [" .. table.concat(names, " ") .. "]"
	end,
	on_click = {
		callback = function()
			vim.defer_fn(function()
				vim.cmd("LspInfo")
			end, 100)
		end,
		name = "heirline_LSP",
	},
	hl = {
		fg = colors.green.hex,
		bold = true,
	},
}

local Diagnostics = {
	condition = conditions.has_diagnostics,
	update = { "DiagnosticChanged", "BufEnter" },
	static = {
		error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
		warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
		info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
		hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
	},
	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,
	{
		provider = function(self)
			-- 0 is just another output, we can decide to print it or not!
			return self.errors > 0 and (self.error_icon .. self.errors .. " ")
		end,
		hl = {
			fg = colors.red.hex,
		},
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
		end,
		hl = {
			fg = colors.yellow.hex,
		},
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info_icon .. self.info .. " ")
		end,
		hl = {
			fg = colors.blue.hex,
		},
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints)
		end,
		hl = {
			fg = colors.white.hex,
		},
	},
	on_click = {
		callback = function()
			vim.defer_fn(function()
				vim.cmd("Telescope diagnostics")
			end, 100)
		end,
		name = "heirline_diagnostics",
	},
}

local Git = {
	condition = conditions.is_git_repo,
	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,
	hl = {
		fg = colors.purple.hex,
	},
	{
		-- git branch name
		provider = function(self)
			return " " .. self.status_dict.head .. " "
		end,
		hl = {
			bold = true,
		},
	},
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and (" " .. count .. " ")
		end,
		hl = {
			fg = colors.green.hex,
		},
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and (" " .. count .. " ")
		end,
		hl = {
			fg = colors.red.hex,
		},
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and (" " .. count .. " ")
		end,
		hl = {
			fg = colors.blue.hex,
		},
	},
}

local TerminalName = {
	-- we could add a condition to check that buftype == 'terminal'
	-- or we could do that later (see #conditional-statuslines below)
	provider = function()
		local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
		return "  " .. tname
	end,
	hl = {
		fg = colors.green.hex,
		bold = true,
	},
}

local HelpFileName = {
	condition = function()
		return vim.bo.filetype == "help"
	end,
	provider = function()
		local filename = vim.api.nvim_buf_get_name(0)
		return " " .. vim.fn.fnamemodify(filename, ":t")
	end,
	hl = {
		fg = colors.yellow.hex,
		bold = true,
	},
}

local Snippets = {
	-- check that we are in insert or select mode
	condition = function()
		return vim.tbl_contains({ "s", "i" }, vim.fn.mode())
	end,
	provider = function()
		local luasnip = require("luasnip")
		local forward = luasnip.expand_or_locally_jumpable() and "" or ""
		local backward = luasnip.jumpable(-1) and " " or ""
		return backward .. forward
	end,
	hl = {
		fg = colors.red.hex,
		bold = true,
	},
}

--  ╭──────────────────────────────────────────────────────────╮
--  │ Statuslines                                              │
--  ╰──────────────────────────────────────────────────────────╯
local SpecialStatusline = {
	condition = function()
		return conditions.buffer_matches({
			buftype = { "nofile", "prompt", "help", "quickfix", "neo-tree" },
			filetype = { "^git.*", "fugitive" },
		})
	end,
	ViMode,
	WorkDir,
	Space,
	HelpFileName,
	Git,
	Align,
	Ruler,
	Space,
	ScrollBar,
}

local TerminalStatusLine = {
	condition = function()
		return conditions.buffer_matches({ buftype = { "terminal" } })
	end,
	ViMode,
	Space,
	TerminalName,
	Align,
	Ruler,
	Space,
	ScrollBar,
}

local InactiveStatusLine = {
	condition = conditions.is_not_active,
	ViMode,
	Space,
	WorkDir,
	Space,
	Git,
	Align,
	LSPActive,
	Space,
	Diagnostics,
	Align,
}

local DefaultStatusLine = {
	ViMode,
	MacroRec,
	ReadOnly,
	WorkDir,
	-- FileName,
	Space,
	Git,
	Align,
	Snippets,
	Space,
	Diagnostics,
	Space,
	LSPActive,
	Space,
	FileType,
	Space,
	FileSize,
	Space,
	Ruler,
	Space,
	ScrollBar,
}

local StatusLines = {
	static = {
		mode_colors_map = {
			n = colors.blue.hex,
			i = colors.green.hex,
			v = colors.orange.hex,
			V = colors.orange.hex,
			["\22"] = colors.cyan.hex,
			c = colors.purple.hex,
			s = colors.green.hex,
			S = colors.green.hex,
			["\19"] = colors.purple.hex,
			r = colors.red.hex,
			R = colors.red.hex,
			["!"] = colors.red.hex,
			t = colors.green.hex,
		},
		mode_color = function(self)
			local mode = conditions.is_active() and vim.fn.mode() or "n"
			return self.mode_colors_map[mode]
		end,
	},
	hl = function()
		if conditions.is_active() then
			return {
				bg = colors.black.hex,
			}
		else
			return {
				bg = "none",
			}
		end
	end,
	fallthrough = false,
	SpecialStatusline,
	TerminalStatusLine,
	InactiveStatusLine,
	DefaultStatusLine,
}

local Tabpage = {
	provider = function(self)
		return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
	end,
	hl = function(self)
		if not self.is_active then
			return "TabLine"
		else
			return "TabLineSel"
		end
	end,
}

local TabpageClose = {
	provider = "%999X  %X",
	hl = "TabLine",
}

local TabPages = {
	-- only show this component if there's 2 or more tabpages
	condition = function()
		return #vim.api.nvim_list_tabpages() >= 2
	end,
	{ provider = "%=" },
	utils.make_tablist(Tabpage),
	TabpageClose,
}

local TabLineOffset = {
	condition = function(self)
		local win = vim.api.nvim_tabpage_list_wins(0)[1]
		local bufnr = vim.api.nvim_win_get_buf(win)
		self.winid = win

		if vim.bo[bufnr].filetype == "neo-tree" then
			self.title = "Files"
			return true
		end
	end,
	provider = function(self)
		local title = self.title
		local width = vim.api.nvim_win_get_width(self.winid)
		local pad = math.ceil((width - #title) / 2)
		return string.rep(" ", pad) .. title .. string.rep(" ", pad)
	end,
	hl = "StatusLine",
	-- { provider = "▏", hl = "TablineLeftSeparator" },
}

local TablineBufnr = {
	provider = function(self)
		return tostring(self.bufnr) .. ". "
	end,
	hl = "Comment",
}

-- we redefine the filename component, as we probably only want the tail and not the relative path
local TablineFileName = {
	provider = function(self)
		-- self.filename will be defined later, just keep looking at the example!
		local filename = self.filename
		filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
		return filename
	end,
	hl = function(self)
		return {
			bold = self.is_active,
			italic = self.is_active and self.is_visible,
			fg = self.is_active and self.is_visible and colors.white.hex or colors.white.darken(50).hex,
		}
	end,
}

-- this looks exactly like the FileFlags component that we saw in
-- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
-- also, we are adding a nice icon for terminal buffers.
local TablineFileFlags = {
	{
		condition = function(self)
			return vim.api.nvim_buf_get_option(self.bufnr, "modified")
		end,
		provider = "  ",
		hl = { fg = colors.red.hex },
	},
	{
		condition = function(self)
			return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
				or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
		end,
		provider = function(self)
			if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
				return "  "
			else
				return ""
			end
		end,
		hl = { fg = colors.orange.hex },
	},
}

-- Here the filename block finally comes together
local TablineFileNameBlock = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(self.bufnr)
	end,
	hl = function(self)
		if self.is_active or self.is_visible then
			return "TabLineSel"
			-- why not?
			-- elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
			--     return { fg = "gray" }
		else
			return "TabLine"
		end
	end,
	on_click = {
		callback = function(_, minwid, _, button)
			if button == "m" then -- close on mouse middle click
				vim.schedule(function()
					vim.api.nvim_buf_delete(minwid, { force = false })
				end)
			else
				vim.api.nvim_win_set_buf(0, minwid)
			end
		end,
		minwid = function(self)
			return self.bufnr
		end,
		name = "heirline_tabline_buffer_callback",
	},
	{
		provider = "▎",
		hl = function(self)
			if self.is_active or self.is_visible then
				return { fg = colors.blue.hex, bg = colors.gray2 }
			end
		end,
	},
	-- Space,
	FileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
	TablineFileName,
	TablineFileFlags,
}

-- a nice "x" button to close the buffer
local TablineCloseButton = {
	condition = function(self)
		return not vim.api.nvim_buf_get_option(self.bufnr, "modified")
	end,
	{
		provider = "  ",
		hl = function(self)
			if self.is_active or self.is_visible then
				return { fg = colors.white.hex, bg = colors.gray2 }
			end
		end,
		on_click = {
			callback = function(_, minwid)
				vim.schedule(function()
					vim.api.nvim_buf_delete(minwid, { force = false })
					vim.cmd.redrawtabline()
				end)
			end,
			minwid = function(self)
				return self.bufnr
			end,
			name = "heirline_tabline_close_buffer_callback",
		},
	},
	hl = function(self)
		if self.is_active or self.is_visible then
			return "TabLineSel"
			-- why not?
			-- elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
			--     return { fg = "gray" }
		else
			return "TabLine"
		end
	end,
}

-- The final touch!
-- local TablineBufferBlock = utils.surround({ "█", "█" }, function(self)
-- 	if self.is_active then
-- 		return utils.get_highlight("TabLineSel").bg
-- 	else
-- 		return utils.get_highlight("TabLine").bg
-- 	end
-- end, { TablineFileNameBlock, TablineCloseButton })

local TablineBufferBlock = {
	TablineFileNameBlock,
	TablineCloseButton,
}

-- and here we go
local BufferLine = utils.make_buflist(
	TablineBufferBlock,
	{ provider = "", hl = { fg = colors.gray } }, -- left truncation, optional (defaults to "<")
	{ provider = "", hl = { fg = colors.gray } } -- right truncation, also optional (defaults to ...... yep, ">")
-- by the way, open a lot of buffers and try clicking them ;)
)

local TabLine = {
	TabLineOffset,
	BufferLine,
	{ provider = "▏", hl = { fg = colors.gray, bg = colors.black.hex } },
	TabPages,
}

require("heirline").setup({
	statusline = StatusLines,
	tabline = TabLine,
})

vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

-- vim:tabstop=4
