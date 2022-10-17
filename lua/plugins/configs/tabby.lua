require("tabby.tabline").set(function(line)
    local left_sep = line.sep("", "BufferTabpageFill", "BufferTabpageFillB")
    local right_sep = line.sep("", "BufferTabpageFill", "BufferTabpageFillB")

    return {
        line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            return {
                left_sep,
                win.file_icon(),
                win.buf_name(),
                win.is_current() and "*" or "",
                right_sep,
                margin = " ",
                hl = "BufferBg",
            }
        end),
        line.spacer(),
        line.tabs().foreach(function(tab)
            return {
                left_sep,
                tab.number(),
                tab.name(),
                tab.is_current() and "*" or "",
                tab.close_btn(""),
                right_sep,
                margin = " ",
                hl = "BufferBg",
            }
        end),
    }
end)
