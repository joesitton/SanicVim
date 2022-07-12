require("auto-session").setup({
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = false,
    auto_session_suppress_dirs = { "~/" },
    bypass_session_save_file_types = { "nowrite", "alpha", "", nil },
    post_restore_cmds = {
        function()
            if not vim.api.nvim_buf_get_name(0) then
                vim.cmd([[bd]])
            end
        end,
    },
})
