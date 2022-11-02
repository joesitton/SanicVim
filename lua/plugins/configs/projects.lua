require("project_nvim").setup({
    exclude_dirs = { "~/.local/*" },
    silent_chdir = false,
})
require("telescope").load_extension("projects")
