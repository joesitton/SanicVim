-- Mappings
local map = require("helpers.mapping")

map.n("k", "gk")
map.n("j", "gj")
map.n("Q", "@q")
map.n("'", "`")
map.n("<CR>", "<CMD>nohlsearch<CR>")

map.n("<C-h>", "<C-w>h")
map.n("<C-j>", "<C-w>j")
map.n("<C-k>", "<C-w>k")
map.n("<C-l>", "<C-w>l")

map.v("<", "<gv")
map.v(">", ">gv")
map.v("<C-S-h>", "<gv")
map.v("<C-S-l>", ">gv")

for _, mode in ipairs({"n", "o"}) do
    local m = map[mode]
    m("c", '"_c')
    m("C", '"_C')
    m("x", '"_x')
    m("X", '"_X')
end
