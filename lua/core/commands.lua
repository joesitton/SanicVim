local cc = vim.api.nvim_create_user_command

-- sudo save
cc("W", ":silent! w !sudo tee % >/dev/null", {})

-- save session and force quit
cc("Q", function()
   vim.cmd("SessionSave")
   vim.cmd("qa!")
end, {})

cc("Format", function()
   vim.lsp.buf.format()
   vim.cmd("w! | e")
end, {})

cc("Rename", function()
   vim.lsp.buf.rename()
end, {})

-- cc("Venv", function()
--    vim.cmd("lua require('swenv.api').pick_venv()")
-- end, {})
