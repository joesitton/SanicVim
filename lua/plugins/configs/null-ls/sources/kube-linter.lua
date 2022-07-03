local null_ls = require("null-ls")

local kube_linter = {
    name = "kube_linter",
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "yaml.kube" },
    generator = null_ls.generator({
        command = "kube-linter",
        args = { "lint", "--format", "json", "$FILENAME" },
        format = "json",
        to_stdin = false,
        from_stderr = false,
        on_output = function(params)
            local diags = {}

            -- for _, d in ipairs(params.output.Issues) do
            --     if d.Pos.Filename == params.bufname then
            --         table.insert(diags, {
            --             row = d.Pos.Line,
            --             col = d.Pos.Column,
            --             message = d.Text,
            --         })
            --     end
            -- end

            return diags
        end,
    }),
}

null_ls.register(kube_linter)

return kube_linter
