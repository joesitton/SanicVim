require("persisted").setup({
    git_use_branch = true,
    should_autosave = function()
        for _, ft in ipairs({ "packer", "neo-tree", "aerial", "nowrite", "alpha", "", nil }) do
            if vim.bo.filetype == ft then
                return false
            end
        end

        return true
    end,
    after_save = function()
        vim.notify("Session was saved!")
    end,
    after_source = function()
        vim.notify("Loaded session!")
    end,
    telescope = {
        before_source = function()
            vim.api.nvim_input("<ESC>:%bd<CR>")
        end,
        after_source = function(session)
            notify("Loaded session " .. session.name)
        end,
    },
})
