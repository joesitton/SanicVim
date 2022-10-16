local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

-- local augroup = vim.api.nvim_create_augroup("auto_format", {})

null_ls.setup({
    sources = {
        formatting.black.with({ to_temp_file = false }),
        formatting.isort.with({ to_temp_file = false }),
        formatting.stylua.with({ to_temp_file = false, extra_args = { "--indent-width", "4", "--indent-type", "spaces" } }),
        formatting.shellharden.with({ to_temp_file = false }),
        formatting.yamlfmt.with({ to_temp_file = false }),
        formatting.fixjson,
        formatting.trim_whitespace,
        formatting.codespell,
        code_actions.gitsigns,
        code_actions.shellcheck,
        -- code_actions.refactoring,
    },
    -- on_attach = function(client, bufnr)
    --     if client.supports_method("textDocument/formatting") then
    --         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --         vim.api.nvim_create_autocmd("BufWritePre", {
    --             group = augroup,
    --             buffer = bufnr,
    --             callback = function()
    --                 vim.lsp.buf.format({ bufnr = bufnr, async = true })
    --             end,
    --         })
    --     end
    -- end,
})
