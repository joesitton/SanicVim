local cc = vim.api.nvim_create_user_command

-- sudo save
cc("W", function()
	vim.cmd("silent! w !sudo tee % >/dev/null")
end, {})

-- Save session and quit
cc("Q", function()
	vim.cmd([[ qa! ]])
end, {})

-- LSP functions
cc("Format", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, {})

cc("Rename", function()
	vim.lsp.buf.rename()
end, {})

-- cc("Venv", function()
--    cmd("lua require('swenv.api').pick_venv()")
-- end, {})
