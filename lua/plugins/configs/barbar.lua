require("bufferline").setup({
	animation = true,
	auto_hide = false,
	tabpages = true,
	closable = true,
	clickable = true,
	exclude_ft = { "alpha" },
	exclude_name = {},
	insert_at_end = false,
	insert_at_start = false,
	maximum_padding = 4,
	maximum_length = 30,
	sidebar_filetypes = {
		NvimTree = { event = "BufWipeout", text = "Files" },
		["neo-tree"] = { event = "BufWipeout", text = "Files" },
	},
	icons = {
		buffer_index = false,
		buffer_number = false,
		inacive = { button = "" },
		modified = { button = "" },
		pinned = { button = "車", filename = true },
		-- diagnostics = {
		-- 	[vim.diagnostic.severity.ERROR] = { enabled = true },
		-- 	[vim.diagnostic.severity.WARN] = { enabled = true },
		-- },
		separator = {
			left = "▎",
			right = "",
		},
		separator_at_end = true,
		filetype = {
			custom_colors = false,
			enabled = true,
		},
	},
})
