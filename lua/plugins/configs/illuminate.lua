require("illuminate").configure({
    delay = 420,
    under_cursor = false,
    large_file_cutoff = 10000,
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
