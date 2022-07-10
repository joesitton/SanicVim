require("aerial").setup({
    filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
        "Boolean",
        "Field",
        "File",
        "Module",
        "Package",
        "Variable",
    },
    icons = require("core.symbols"),
    float = {
        border = "none",
        relative = "win",
        override = function(conf)
            conf.row = 0
            conf.col = vim.o.columns
            conf.height = vim.fn.winheight(0) + 2
            conf.width = 40
        end,
    },
})
