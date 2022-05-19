require("hop").setup({ teasing = false })

local function HopChar1Inc(direction)
    return require("hop").hint_char1({
        direction = require("hop.hint").HintDirection[direction],
        inclusive_jump = true,
        current_line_only = true,
    })
end
