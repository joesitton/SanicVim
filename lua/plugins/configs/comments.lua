require("Comment").setup({
	toggler = {},
	opleader = {
		line = "gc",
	},
	extra = {
		above = "gcO",
		below = "gco",
		eol = "gcA",
	},
	ignore = "^$",
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
	-- pre_hook = function(ctx)
	-- 	if vim.bo.filetype == "lua" then
	-- 		return
	-- 	end

	-- 	local U = require("Comment.utils")
	-- 	local location = nil

	-- 	if ctx.ctype == U.ctype.block then
	-- 		location = require("ts_context_commentstring.utils").get_cursor_location()
	-- 	elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
	-- 		location = require("ts_context_commentstring.utils").get_visual_start_location()
	-- 	end

	-- 	return require("ts_context_commentstring.internal").calculate_commentstring({
	-- 		key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
	-- 		location = location,
	-- 	})
	-- end,
})
