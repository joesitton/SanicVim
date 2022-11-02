local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

local augroup = vim.api.nvim_create_augroup("auto_format", {})

null_ls.setup({
    sources = {
        formatting.black,
        formatting.isort,
        formatting.stylua.with({
            extra_args = { "--indent-width", "4", "--indent-type", "spaces" },
        }),
        formatting.shellharden,
        formatting.yamlfmt,
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
    --                 if vim.fn.fnamemodify(vim.fn.expand("%"), ":t") == "lush-base16.lua" then
    --                     return
    --                 end

    --                 vim.lsp.buf.format({ bufnr = bufnr })
    --             end,
    --         })
    --     end
    -- end,
})
