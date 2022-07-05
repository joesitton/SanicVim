local cc = vim.api.nvim_create_user_command

-- Save a file with sudo
cc("W", ":silent! w !sudo tee % >/dev/null", {})
