local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local heirline = require("heirline")

local colors = require("lush_theme.colors")
colors.gray = colors.black.lighten(20).hex
colors.gray2 = colors.black.lighten(4).hex

local Align = { provider = "%=" }
local Space = { provider = " " }

local function surround_left(object, color)
	return {
		{ provider = " ", hl = { bg = color } },
		{ object, hl = { bg = color } },
		{ provider = " ", hl = { bg = color } },
		{ provider = "", hl = { fg = color } },
	}
end

local function surround_right(object, color)
	return {
		{ provider = "", hl = { fg = color } },
		{ provider = " ", hl = { bg = color } },
		{ object, hl = { bg = color } },
		{ provider = " ", hl = { bg = color } },
	}
end

local ViMode = {
	update = { "ModeChanged" },
	provider = function(self)
		return "█ " .. vim.fn.mode(1):sub(1, 1) .. " "
	end,
	hl = function(self)
		local color = self:mode_color().hex
		return {
			fg = color,
			bold = true,
		}
	end,
}

local ShowCmd = {
	-- condition = function()
	--     return vim.o.cmdheight == 0
	-- end,
	init = function()
		vim.o.showcmdloc = "statusline"
	end,
	{
		provider = "%S",
		hl = function(self)
			local color = self:mode_color()
			return {
				fg = color,
				bold = true,
			}
		end,
	},
	Space,
}

local WorkDir = {
	init = function(self)
		local cwd = vim.fn.getcwd(0)
		self.cwd = vim.fn.fnamemodify(cwd, ":~") .. "/"
	end,
	flexible = 1,
	{
		surround_left({
			{
				provider = function()
					return (vim.fn.haslocaldir(0) == 1 and "L" or "") .. "  "
				end,
				hl = {
					fg = colors.blue.hex,
					bold = true,
				},
			},
			{
				provider = function(self)
					local trail = self.cwd:sub(-1) == "/" and "" or "/"
					return self.cwd .. trail
				end,
				hl = {
					fg = colors.white.darken(20).hex,
				},
			},
			-- {
			-- 	provider = "",
			-- }
		}, colors.black.lighten(15).hex),
	},
	{
		provider = "",
	},
	-- {
	-- 	provider = function(self)
	-- 		return vim.fn.expand("%:h") .. "/"
	-- 	end,
	-- 	hl = {
	-- 		fg = colors.white.darken(40).hex,
	-- 	},
	-- },
	-- {
	-- 	provider = function(self)
	-- 		return vim.fn.expand("%:t")
	-- 	end,
	-- 	hl = {
	-- 		fg = colors.white.hex,
	-- 		bold = true,
	-- 	},
	-- },
}

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
		local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
		return enc ~= "utf-8" and enc:upper()
	end,
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
	{
		provider = " ",
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
	},
	Space,
}

local ReadOnly = {
	condition = function()
		return (not vim.bo.modifiable or vim.bo.readonly)
			and not conditions.buffer_matches({ buftype = { "help" }, filetype = { "NvimTree" } })
	end,
	{
		provider = "  ",
		hl = {
			fg = colors.red.hex,
		},
	},
	Space,
}

local FileSize = {
	Space,
	{
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
		hl = {
			fg = colors.white.hex,
		},
	},
}

local Ruler = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	-- provider = "%7(%l/%3L%):%2c 0x%B %P",
	{
		provider = "%P",
		hl = {
			fg = colors.orange.hex,
		},
	},
	Space,
}

local FileType = {
	provider = function()
		return vim.bo.filetype
	end,
	hl = {
		fg = colors.yellow.hex,
		bold = true,
	},
}

local ScrollBar = {
	static = {
		sbar = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" },
	},
	{
		provider = function(self)
			local curr_line = vim.api.nvim_win_get_cursor(0)[1]
			local lines = vim.api.nvim_buf_line_count(0)
			local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
			return string.rep(self.sbar[i], 2)
		end,
		hl = {
			fg = colors.white.darken(50).hex,
			bg = colors.black.lighten(10).hex,
		},
	},
	Space,
}

local LSPActive = {
	condition = conditions.lsp_attached,
	update = { "ModeChanged", "LspAttach", "LspDetach" },
	-- flexible = 1,
	{
		surround_right({
			provider = function()
				local names = {}
				for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
					table.insert(names, server.name)
				end
				return " " .. table.concat(names, " ")
			end,
			-- on_click = {
			-- 	callback = function()
			-- 		vim.defer_fn(function()
			-- 			vim.cmd("LspInfo")
			-- 		end, 100)
			-- 	end,
			-- 	name = "heirline_LSP",
			-- },
			hl = {
				fg = colors.green.darken(75).hex,
				bold = true,
			},
		}, colors.green.hex),
	},
	-- {
	-- 	provider = "",
	-- },
}

local Diagnostics = {
	condition = conditions.has_diagnostics,
	update = { "DiagnosticChanged", "BufEnter", "ModeChanged" },
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

local Lazy = {
	condition = require("lazy.status").has_updates,
	update = { "User", pattern = "LazyUpdate" },
	{
		provider = function()
			return " " .. require("lazy.status").updates() .. " "
		end,
		on_click = {
			callback = function()
				require("lazy").update()
			end,
			name = "update_plugins",
		},
		hl = { fg = colors.gray.hex },
	},
	Space,
}

local SearchCount = {
	condition = function()
		return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
	end,
	init = function(self)
		local ok, search = pcall(vim.fn.searchcount)
		if ok and search.total then
			self.search = search
		end
	end,
	provider = function(self)
		local search = self.search
		return string.format("[%d/%d]", search.current, math.min(search.total, search.maxcount))
	end,
	hl = {
		fg = colors.yellow.hex,
	},
}

local GitBranch = {
	update = { "ModeChanged", "FileType", "Bufenter", "FocusGained" },
	condition = function(self)
		return self.branch ~= nil or conditions.is_git_repo
	end,
	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.branch = vim.b.gitsigns_head or vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
	end,
	-- git branch name
	surround_left({
		provider = function(self)
			return " " .. self.branch
		end,
		hl = {
			fg = colors.purple.darken(75).hex,
			bold = true,
		},
	}, colors.purple.hex),
	Space,
}

local GitDiff = {
	condition = conditions.is_git_repo,
	update = { "ModeChanged", "BufWritePost" },
	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,
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
	Space,
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
		return "  " .. vim.fn.fnamemodify(filename, ":t")
	end,
	hl = {
		fg = colors.yellow.hex,
		bold = true,
	},
}

-- local Snippets = {
-- 	-- check that we are in insert or select mode
-- 	condition = function()
-- 		return vim.tbl_contains({ "s", "i" }, vim.fn.mode())
-- 	end,
-- 	provider = function()
-- 		local luasnip = require("luasnip")
-- 		local forward = luasnip.expand_or_locally_jumpable() and "" or ""
-- 		local backward = luasnip.jumpable(-1) and " " or ""
-- 		return backward .. forward
-- 	end,
-- 	hl = {
-- 		fg = colors.red.hex,
-- 		bold = true,
-- 	},
-- }

-- local VirtualEnv = {
-- 	condition = function()
-- 		local ok, swenv = pcall(require, "swenv.api")
-- 		if not ok then
-- 			return false
-- 		end

-- 		return swenv.get_current_venv() ~= nil
-- 	end,
-- 	provider = function()
-- 		local ok, swenv = pcall(require, "swenv.api")
-- 		if ok then
-- 			return "  " .. swenv.get_current_venv().name
-- 		end
-- 		return ""
-- 	end,
-- 	hl = {
-- 		fg = colors.green.hex,
-- 		bold = true,
-- 	},
-- }

local Session = {
	update = { "ModeChanged", "VimEnter" },
	condition = function()
		return require("auto-session.lib").current_session_name() ~= nil
	end,
	provider = function()
		return "  " .. require("auto-session.lib").current_session_name()
	end,
	hl = {
		fg = colors.yellow.hex,
		bg = colors.yellow.darken(75).hex,
	},
}

--  ╭──────────────────────────────────────────────────────────╮
--  │ Statuslines                                              │
--  ╰──────────────────────────────────────────────────────────╯
-- local SpecialStatusline = {
-- 	condition = function()
-- 		return conditions.buffer_matches({
-- 			buftype = { "nofile", "prompt", "help", "quickfix", "neo-tree", "NvimTree_*", "TelescopePrompt" },
-- 			filetype = { "^git.*", "fugitive" },
-- 		})
-- 	end,
-- 	ViMode,
-- 	Lazy,
-- 	MacroRec,
-- 	WorkDir,
-- 	surround_left({ Session }, colors.yellow.darken(75).hex),
-- 	GitBranch,
-- 	ReadOnly,
-- 	HelpFileName,
-- 	Align,
-- 	surround_right({
-- 		FileType,
-- 		FileSize,
-- 	}, colors.black.lighten(15).hex),
-- 	Space,
-- 	Ruler,
-- 	Space,
-- }

local TerminalStatusLine = {
	condition = function()
		return conditions.buffer_matches({ buftype = { "terminal" } })
	end,
	ViMode,
	WorkDir,
	-- surround_left({ Session }, colors.yellow.darken(75).hex),
	Space,
	TerminalName,
	Align,
	Ruler,
	Space,
}

local DefaultStatusLine = {
	ViMode,
	Lazy,
	MacroRec,
	WorkDir,
	-- surround_left({ Session }, colors.yellow.darken(75).hex),
	ReadOnly,
	GitBranch,
	GitDiff,
	Align,
	-- Snippets,
	Diagnostics,
	LSPActive,
	surround_right({
		FileType,
		-- FileEncoding,
		FileSize,
	}, colors.black.lighten(15).hex),
	Space,
	Ruler,
	Space,
}

local InactiveStatusLine = {
	condition = conditions.is_not_active,
	ViMode,
	GitBranch,
	GitDiff,
	Align,
	LSPActive,
	Diagnostics,
}

local StatusLines = {
	static = {
		mode_colors_map = {
			n = colors.blue,
			i = colors.green,
			v = colors.orange,
			V = colors.orange,
			["\22"] = colors.cyan,
			c = colors.purple,
			s = colors.green,
			S = colors.green,
			["\19"] = colors.purple,
			r = colors.red,
			R = colors.red,
			["!"] = colors.red,
			t = colors.green,
		},
		mode_color = function(self)
			local mode = conditions.is_active() and vim.fn.mode() or "n"
			return self.mode_colors_map[mode]
		end,
	},
	hl = function(self)
		return {
			fg = self:mode_color().darken(75).hex,
			bg = self:mode_color().darken(75).hex,
		}
	end,
	fallthrough = false,
	-- SpecialStatusline,
	TerminalStatusLine,
	InactiveStatusLine,
	DefaultStatusLine,
}

require("heirline").setup({
	statusline = StatusLines,
})

vim.cmd("au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif")

-- vim:tabstop=4
