require("tabby.tabline").set(function(line)
    return {
        line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            return {
                win.file_icon(),
                " ",
                win.buf_name(),
            }
        end),
        line.spacer(),
        line.tabs().foreach(function(tab)
            return {
                tab.number(),
                " ",
                tab.name(),
                " ",
                tab.close_btn(" "),
            }
        end),
    }
end)
