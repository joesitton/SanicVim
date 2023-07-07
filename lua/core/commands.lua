local cc = vim.api.nvim_create_user_command

cc("W", ":silent! w !sudo tee % >/dev/null", {}) -- Save a file with sudo

cc("Q", function ()
   vim.cmd("SessionSave")
   vim.cmd("qa!")
end, {}) -- Force quit

cc("Format", function()
   vim.lsp.buf.format()
   -- vim.cmd("w!")
end, {})

cc("Rename", function ()
   vim.lsp.buf.rename()
end, {})

cc("Venv", function()
   vim.cmd("lua require('swenv.api').pick_venv()")
end, {})
