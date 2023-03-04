vim.diagnostic.config({
    signs = true,
    update_in_insert = false,
    virtual_text = {
        prefix = "•",
        severity_sort = true,
    },
    float = {
        header = false,
        border = "rounded",
        severity_sort = true,
        source = "always",
        focusable = false,
    },
})

require("mason").setup({
    ui = {
        border = "rounded",
    },
})

require("null-ls").setup()

require("mason-null-ls").setup({
    automatic_setup = true,
    ensure_installed = {
        "black",
        "isort",
        "fixjson",
        "jq",
        "stylua",
        "yamlfmt",
        "shellharden"
    },
})

require("mason-null-ls").setup_handlers({
    function(source_name, methods)
        require("mason-null-ls.automatic_setup")(source_name, methods)
    end,
})

local servers = {
    "pyright",
    "gopls",
    "dockerls",
    "bashls",
    "ansiblels",
    "jsonls",
    "yamlls",
    "vimls",
    "rust_analyzer",
    "terraformls",
}

require("mason-lspconfig").setup({
    ensure_installed = servers,
})

require("lspconfig.ui.windows").default_options.border = "rounded"

local lsp = require("lspconfig")

local on_attach = function(client, bufnr)
    local ok, navic = pcall(require, "nvim-navic")

    if ok then
        navic.attach(client, bufnr)
    end
end

for _, server in ipairs(servers) do
    local settings = {}

    if server == "jsonls" then
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
            },
        }
    elseif server == "pyright" then
        settings = {
            python = {
                analysis = {
                    extraPaths = { "/opt/homebrew/lib/python3.10/site-packages" }
                }
            }
        }
    end

    lsp[server].setup({
        on_attach = on_attach,
        settings = settings,
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        flags = {
            debounce_text_changes = 300,
        },
    })
end
