local cmp = require("cmp")

-- autopairs
local ok, autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if ok then
	cmp.event:on("confirm_done", autopairs.on_confirm_done())
end

-- git
local ok, cmp_git = pcall(require, "cmp_git")
if ok then
	cmp_git.setup()
end

-- tabnine
local ok, tabnine = pcall(require, "cmp_tabnine.config")
if ok then
	tabnine:setup({
		max_lines = 1000,
		max_num_results = 3,
		sort = false,
		run_on_every_keystroke = false,
		snippet_placeholder = "..",
		ignored_file_types = {},
		show_prediction_strength = true,
	})
end

-- menu appearance
local symbol_map = require("core.utils").symbols
local menu = {
	cmdline = "Cmd",
	buffer = "Buffer",
	["buffer-lines"] = "Buffer",
	path = "Path",
	async_path = "Path",
	nvim_lsp = "LSP",
	nvim_lua = "Lua",
	luasnip = "Snippet",
	latex_symbols = "LaTeX",
	rg = "Ripgrep",
	calc = "Calc",
	treesitter = "TreeSitter",
	emoji = "Emoji",
	conventionalcommits = "Commit",
	cmdline_history = "History",
	git = "Git",
	cmp_tabnine = "TabNine",
	copilot = "Copilot",
	neorg = "Neorg",
	nvim_lsp_signature_help = "Sig",
}

-- snippets
local luasnip = require("luasnip")

-- local has_words_before = function()
-- 	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
-- 		return false
-- 	end
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
-- end

cmp.event:on("menu_opened", function()
	vim.b.copilot_suggestion_hidden = true
end)

cmp.event:on("menu_closed", function()
	vim.b.copilot_suggestion_hidden = false
end)

cmp.setup({
	enabled = function()
		local ft = vim.bo.filetype

		if ft == "TelescopePrompt" or ft == "neo-tree-popup" then
			return false
		end

		local ctx = require("cmp.config.context")
		if ctx.in_treesitter_capture("comment") == true or ctx.in_syntax_group("Comment") then
			return false
		end

		return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
	end,
	view = {
		entries = {
			name = "custom",
			selection_order = "near_cursor",
		},
	},
	experimental = {
		native_menu = false,
		ghost_text = {
			hl_group = "CmpGhostText",
		},
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		maxwidth = 50,
		ellipsis_char = "...",
		format = function(entry, vim_item)
			vim_item.menu = "        " .. menu[entry.source.name]

			if entry.source.name == "treesitter" then
				vim_item.kind = "   "
				vim_item.kind_hl_group = "CmpItemKindTreesitter"
			else
				vim_item.kind = " " .. symbol_map[vim_item.kind] .. " "
			end

			return vim_item
		end,
	},
	preselect = cmp.PreselectMode.None,
	window = {
		completion = {
			col_offset = -5,
			side_padding = 0,
			zindex = 99,
			border = "rounded",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:FloatSel",
		},
		documentation = {
			zindex = 99,
			border = "rounded",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:FloatSel",
		},
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<CR>"] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() and cmp.get_active_entry() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
					-- elseif cmp.visible() and not cmp.get_active_entry() then
					-- 	cmp.close()
				else
					fallback()
				end
			end,
			s = cmp.mapping.confirm({ select = true }),
			-- c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		}),
		["<C-Space>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.close()
			elseif not cmp.visible() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then -- and has_words_before() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
				-- elseif has_words_before() then
				-- 	cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<ESC>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.mapping.abort()
				vim.cmd([[stopinsert]])
			else
				fallback()
			end
		end, { "i" }),
	},
	sources = {
		{ name = "copilot",                priority = 9 },
		{ name = "cmp_tabnine",            priority = 9 },
		{ name = "nvim_lsp",               priority = 8 },
		{ name = "nvim_lua",               priority = 8 },
		{ name = "buffer",                 priority = 7 },
		-- { name = "buffer-lines",           priority = 7 },
		{ name = "emoji",                  priority = 6 },
		{ name = "luasnip",                priority = 6 },
		-- { name = "treesitter",             priortiy = 5 },
		{ name = "async_path",             priority = 4 },
		{ name = "calc",                   priority = 3 },
		{ name = "nvim_lsp_signature_help" },
		-- { name = "latex_symbols" },
	},
	sorting = {
		priority_weight = 1.0,
		comparators = {
			require("copilot_cmp.comparators").prioritize,
			-- require("cmp_tabnine.compare"),
			cmp.config.compare.locality,
			cmp.config.compare.recently_used,
			cmp.config.compare.sort_text,
			cmp.config.compare.score,
			cmp.config.compare.offset,
			cmp.config.compare.order,
			require("cmp-under-comparator").under,
			-- cmp.config.compare.exact,
			-- cmp.config.compare.kind,
			-- cmp.config.compare.length,
		},
	},
})

cmp.setup.cmdline(":", {
	view = { entries = { name = "custom", selection_order = "near_cursor" } },
	window = { completion = { side_padding = 1, col_offset = 0 } },
	formatting = { fields = { "abbr" }, maxwidth = 120 },
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "async_path" },
		{ name = "cmdline" },
	}),
})

for _, cmdtype in ipairs({ "?", "/" }) do
	cmp.setup.cmdline(cmdtype, {
		view = { entries = { name = "custom", selection_order = "near_cursor" } },
		window = { completion = { side_padding = 1, col_offset = 0 } },
		formatting = { fields = { "abbr" }, maxwidth = 120 },
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{
				name = "buffer",
			},
			-- { name = "buffer-lines" },
			-- {
			-- 	name = "rg",
			-- 	keyword_length = 3,
			-- 	option = {
			-- 		additional_arguments = "--smart-case",
			-- 	},
			-- },
			-- { name = "nvim_lsp_document_symbol" },
			-- { name = "treesitter", },
		}),
	})
end

cmp.setup.filetype("gitcommit", {
	formatting = { fields = { "kind", "abbr" } },
	window = { completion = { side_padding = 1, col_offset = 0 } },
	sources = cmp.config.sources({
		-- { name = "conventionalcommits" },
		{ name = "git" },
	}),
})

-- cmp.setup.filetype("norg", {
-- 	window = { completion = { side_padding = 1, col_offset = 0 } },
-- 	sources = cmp.config.sources({
-- 		{ name = "neorg" },
-- 		{
-- 			name = "rg",
-- 			option = {
-- 				additional_arguments = "--smart-case",
-- 				only_current_buffer = true,
-- 			},
-- 		},
-- 	}),
-- })

-- cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
-- 	view = { entries = { name = "custom", selection_order = "near_cursor" } },
-- 	window = { completion = { side_padding = 1, col_offset = 0 } },
-- 	formatting = { fields = { "abbr" }, maxwidth = 120 },
-- 	sources = cmp.config.sources({
-- 		{ name = "dap" },
-- 	}),
-- })
