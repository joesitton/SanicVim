require("auto-session").setup({
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = false,
    bypass_session_save_file_types = { "nowrite", "alpha", "", nil },
    post_restore_cmds = {
        function()
            if not vim.bo.filetype then
                vim.cmd([[bd]])
            end
        end,
    },
})
