local npairs = require("nvim-autopairs")

npairs.setup({
    check_ts = true,
    enable_check_bracket_line = false,
    disable_filetype = { "TelescopePrompt" },
})

-- local Rule = require("nvim-autopairs.rule")
-- local ts_conds = require("nvim-autopairs.ts-conds")
-- local conds = require("nvim-autopairs.conds")

-- -- npairs.add_rules({
-- --     Rule('"', '"')
-- --         :with_move(function ()
-- --             return conds.not_after_text('"') and conds.is_inside_quote()
-- --         end)
-- -- })

-- local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
-- npairs.add_rules({
--     Rule(" ", " "):with_pair(function(opts)
--         local pair = opts.line:sub(opts.col - 1, opts.col)
--         return vim.tbl_contains({
--             brackets[1][1] .. brackets[1][2],
--             brackets[2][1] .. brackets[2][2],
--             brackets[3][1] .. brackets[3][2],
--         }, pair)
--     end),
-- })
-- for _, bracket in pairs(brackets) do
--     npairs.add_rules({
--         Rule(bracket[1] .. " ", " " .. bracket[2])
--             :with_pair(function()
--                 return false
--             end)
--             :with_move(function(opts)
--                 return opts.prev_char:match(".%" .. bracket[2]) ~= nil
--             end)
--             :use_key(bracket[2]),
--     })
-- end
