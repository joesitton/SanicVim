require("auto-session").setup({
    auto_session_enabled = false,
    auto_save_enabled = false,
    auto_restore_enabled = true,
    bypass_session_save_file_types = { "nowrite", "alpha", "", nil },
})
