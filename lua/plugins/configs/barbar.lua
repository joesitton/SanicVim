require("bufferline").setup({
	animation = true,
	auto_hide = false,
	tabpages = true,
	closable = true,
	clickable = true,
	exclude_ft = { "alpha" },
	exclude_name = {},
	icons = {
		separator = {
			left = "▎",
			right = "",
		},
		filetype = {
			custom_colors = false,
			enabled = true,
		},
		inacive = { button = "" },
		modified = { button = "" },
		pinned = { button = "車" },
	},
	separator = {
		left = "▎",
		right = " ",
	},
	insert_at_end = false,
	insert_at_start = false,
	maximum_padding = 2,
	maximum_length = 30,
	sidebar_filetypes = {
		["neo-tree"] = { event = "BufWipeout" },
	},
})
