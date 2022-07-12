require("hlargs").setup({
    excluded_argnames = {
        declarations = {
            python = { "self", "cls" },
            lua = { "self" },
        },
        usages = {
            python = { "self", "cls" },
            lua = { "self" },
        },
    },
    performance = {
        parse_delay = 0,
        slow_parse_delay = 0,
    },
})
