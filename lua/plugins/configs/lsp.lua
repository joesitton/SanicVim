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
        source = "if_many",
        focusable = false,
    },
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
    "sumneko_lua",
    "rust_analyzer",
    "terraformls",
}

require("mason").setup({
    ui = {
        border = "rounded",
    },
})

require("mason-lspconfig").setup({
    ensure_installed = servers,
})

local lsp = require("lspconfig")
require("lspconfig.ui.windows").default_options.border = "rounded"

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
