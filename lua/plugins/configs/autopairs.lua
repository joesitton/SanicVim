local npairs = require("nvim-autopairs")

npairs.setup({
    check_ts = true,
    enable_check_bracket_line = false,
})

local Rule = require("nvim-autopairs.rule")
local ts_conds = require("nvim-autopairs.ts-conds")
local conds = require("nvim-autopairs.conds")

npairs.remove_rule('"')

npairs.add_rules({
    -- Rule('"', '"')
    --     :with_move(conds.after_text('"'))
    --     :with_pair(conds.is_inside_quote())
    --     :with_pair(ts_conds.is_ts_node({ "string", "comment" })),
    Rule("( ", " )")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match(".%)") ~= nil
        end)
        :use_key(")"),
    Rule("{ ", " }")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match(".%}") ~= nil
        end)
        :use_key("}"),
    Rule("[ ", " ]")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match(".%]") ~= nil
        end)
        :use_key("]"),
})
