require("dressing").setup({
    input = {
        default_prompt = "❯ ",
        prompt_align = "center",
        insert_only = true,
        start_in_insert = true,
        relative = "editor",
        prefer_width = 0.5,
        win_options = {
            winblend = 0,
            winhighlight = "Normal:NormalFloat,FloatBorder:TelescopeBorder",
        },
        -- override = function(conf)
        --     -- conf.row = 10
        --     -- conf.col = -1

        --     return conf
        -- end,
    },
    select = {
        enabled = true,
        backend = "telescope",
        format_item_override = {},
        get_config = nil,
    },
})
