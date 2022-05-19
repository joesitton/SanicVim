---@diagnostic disable: undefined-global

local lush = require("lush")
local hsl = lush.hsl

return lush(function()
    return {
        Normal({ bg = hsl(0, 0, 0), fg = "#ffffff" }),
        -- Whitespace({ fg = Normal.fg.darken(40) }),
        -- Comment({ Whitespace, gui = "italic" }),
    }
end)
