local map = vim.api.nvim_set_keymap

local M = {}

-- Normal mode map
M.n = function(key, command)
  map("n", key, command, { noremap = true })
end

-- Input mode map
M.i = function(key, command)
  map("i", key, command, { noremap = true })
end

-- Visual mode map
M.v = function(key, command)
  map("v", key, command, { noremap = true })
end

-- Operator mode map
M.o = function(key, command)
  map("o", key, command, { noremap = true })
end

-- Terminal mode map
M.t = function(key, command)
  map("t", key, command, { noremap = true })
end

return M
