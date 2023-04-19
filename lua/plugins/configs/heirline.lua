local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local heirline = require("heirline")

local colors = require("lush_theme.colors")
colors.gray = colors.white.darken(40)
for k, v in pairs(colors) do
	colors[k] = v.hex
end
heirline.load_colors(colors)

local Align = { provider = "%=" }
local Space = { provider = " " }

local ViMode = {
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
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
			fg = "blue",
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
			fg = colors.gray,
		},
	},
}

-- WorkDir = utils.surround({ "[", "]" }, nil, WorkDir)

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
			fg = "green",
			bold = true,
		},
	}),
	hl = {
		fg = "orange",
		bold = true,
	},
}

local ReadOnly = {
	condition = function()
		return not vim.bo.modifiable or vim.bo.readonly
	end,
	provider = "  ",
	hl = {
		fg = "red",
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
		fg = colors.orange,
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
		fg = "blue",
		bg = colors.black,
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
		return " " .. table.concat(names, " ")
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
		fg = colors.gray,
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
			fg = "red",
		},
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
		end,
		hl = {
			fg = "yellow",
		},
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info_icon .. self.info .. " ")
		end,
		hl = {
			fg = "blue",
		},
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints)
		end,
		hl = {
			fg = "white",
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
		fg = "purple",
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
			fg = "green",
		},
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and (" " .. count .. " ")
		end,
		hl = {
			fg = "red",
		},
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and (" " .. count .. " ")
		end,
		hl = {
			fg = "blue",
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
		fg = "green",
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
		fg = colors.yellow,
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
		fg = "red",
		bold = true,
	},
}

--  ╭──────────────────────────────────────────────────────────╮
--  │ Statuslines                                              │
--  ╰──────────────────────────────────────────────────────────╯
local SpecialStatusline = {
	condition = function()
		return conditions.buffer_matches({
			buftype = { "nofile", "prompt", "help", "quickfix" },
			filetype = { "^git.*", "fugitive" },
		})
	end,
	ViMode,
	Space,
	HelpFileName,
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
}

local InactiveStatusLine = {
	condition = conditions.is_not_active,
	ViMode,
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
			n = "blue",
			i = "green",
			v = "orange",
			V = "orange",
			["\22"] = "cyan",
			c = "purple",
			s = "green",
			S = "green",
			["\19"] = "purple",
			r = "red",
			R = "red",
			["!"] = "red",
			t = "green",
		},
		mode_color = function(self)
			local mode = conditions.is_active() and vim.fn.mode() or "n"
			return self.mode_colors_map[mode]
		end,
	},
	hl = function()
		if conditions.is_active() then
			return {
				bg = colors.black,
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

require("heirline").setup({
	statusline = StatusLines,
})

-- vim:tabstop=4
