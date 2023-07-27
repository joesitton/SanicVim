require("colorizer").setup({
    user_default_options = {
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,
        names = false,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        tailwind = true,
        sass = { enable = true, parsers = { "css" } },
        -- mode = "virtualtext"
    },
    buftypes = {
        "*",
        -- exclude prompt and popup buftypes from highlight
        "!prompt",
        "!popup",
    },
})
