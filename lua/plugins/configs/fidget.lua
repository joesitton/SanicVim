require("fidget").setup({
    text = { done = "", spinner = "dots" },
    -- window = { blend = 0 },
    timer = {
        spinner_rate = 125,  -- frame rate of spinner animation, in ms
        fidget_decay = 4000, -- how long to keep around empty fidget, in ms
        task_decay = 2000,   -- how long to keep around completed task, in ms
    },
    sources = {
        ["null-ls"] = {
            ignore = true,
        },
    },
})
