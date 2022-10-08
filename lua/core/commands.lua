local cc = vim.api.nvim_create_user_command

cc("W", ":silent! w !sudo tee % >/dev/null", {}) -- Save a file with sudo

cc("Q", ":silent! qa!", {}) -- Force quit

cc("Format", function()
   vim.lsp.buf.format()
   vim.cmd("w!")
end, {})
