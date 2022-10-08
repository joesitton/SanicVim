require("auto-session").setup({
    -- auto_session_enable_last_session = true,
    auto_save_enabled = true,
    auto_restore_enabled = false,
    auto_session_use_git_branch = true,
    auto_session_suppress_dirs = { "~/" },
    bypass_session_save_file_types = { "packer", "neo-tree", "aerial", "nowrite", "alpha", "", nil },
})
