require("dressing").setup({
    input = {
        enabled = true,
        default_prompt = "❯ ",
        prompt_align = "center",
        insert_only = true,
        anchor = "SW",
        relative = "editor",
        border = "rounded",
        prefer_width = 40,
        max_width = nil,
        min_width = 20,
        winblend = 0,
        winhighlight = "Normal:NormalFloat,FloatBorder:TelescopeBorder",
        get_config = nil,
        override = function(conf)
            -- conf.row = 10
            -- conf.col = -1

            return conf
        end,
    },
    select = {
        enabled = true,
        backend = "telescope",
        format_item_override = {},
        get_config = nil,
    },
})
