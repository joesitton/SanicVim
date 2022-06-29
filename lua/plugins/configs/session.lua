require("auto-session").setup({
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = false,
    bypass_session_save_file_types = { "nowrite", "alpha", "", nil },
})
