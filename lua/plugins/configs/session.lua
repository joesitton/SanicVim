require("persisted").setup({
	git_use_branch = true,
	should_autosave = function()
		for _, ft in ipairs({ "packer", "neo-tree", "aerial", "nowrite", "alpha", "", nil }) do
			if vim.bo.filetype == ft then
				return false
			end
		end

		return true
	end,
})
