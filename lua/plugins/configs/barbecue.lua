require("barbecue").setup({
	create_autocmd = false,
	attach_navic = false,
	context_follow_icon_color = true,
	show_dirname = true,
	show_basename = true,
	kinds = require("core.utils").symbols,
	theme = {
		normal = { bg = "#212121" }
	}
})
