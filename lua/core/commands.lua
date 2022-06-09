local cc = vim.api.nvim_create_user_command

cc("W", ":silent! w !sudo tee % >/dev/null", {})
