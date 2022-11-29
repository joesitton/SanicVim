require("illuminate").configure({
    delay = 420,
    under_cursor = false,
    filetypes_denylist = {
        "NvimTree",
        "Trouble",
        "Telescope",
        "DiffviewFiles",
        "DiffviewFileHistory",
        "neo-tree",
        "packer",
        "alpha",
    },
})
