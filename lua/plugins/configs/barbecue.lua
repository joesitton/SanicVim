require("barbecue").setup({
	create_autocmd = false,
	attach_navic = false,
	context_follow_icon_color = true,
	kinds = require("core.utils").symbols,
	-- lead_custom_section = function()
	-- 	return ""
	-- end,
	-- custom_section = function ()
	-- 	if require("luasnip").expand_or_locally_jumpable() then
	-- 		return "<Snippet>"
	-- 	else
	-- 		return ""
	-- 	end
	-- end
})
