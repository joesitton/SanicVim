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
        width = 0.7,
        height = 0.7,
    },
})

require("mason-null-ls").setup({
    automatic_installation = true,
    automatic_setup = true,
    ensure_installed = {
        "black",
        "isort",
        "fixjson",
        "jq",
        "stylua",
        "yamlfmt",
        -- "prettier",
    },
    handlers = {},
})

local null_ls = require("null-ls")
null_ls.setup({
    border = "rounded",
    sources = {
        -- null_ls.builtins.formatting.prettier,
        null_ls.builtins.code_actions.gitsigns,
    },
})

require("mason-nvim-dap").setup({
    ensure_installed = { "delve" },
    automatic_installation = true,
    handlers = {},
})

require("neodev").setup({
    library = {
        plugins = { "nvim-dap-ui" },
        types = false,
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
    "lua_ls",
    "rust_analyzer",
    "terraformls",
}

require("mason-lspconfig").setup({
    ensure_installed = servers,
})

require("lspconfig.ui.windows").default_options.border = "rounded"

local lsp = require("lspconfig")

local on_attach = function(client, bufnr)
    if client.server_capabilities["documentSymbolProvider"] then
        require("nvim-navic").attach(client, bufnr)
    end

    -- Disable syntax highlighting from lua_ls
    if client.name == "lua_ls" then
        client.server_capabilities.semanticTokensProvider = nil
    elseif client.name == "copilot" then
        local ok, copilot_cmp = pcall(require, "cmp_copilot")
        if ok then
            copilot_cmp._on_insert_enter()
        end
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
    elseif server == "yamlls" then
        settings = {
            yaml = {
                schemas = require("schemastore").yaml.schemas(),
            },
        }
    elseif server == "pyright" then
        settings = {
            python = {
                analysis = {
                    extraPaths = { "/opt/homebrew/lib/python3.10/site-packages" },
                },
            },
        }
    elseif server == "lua_ls" then
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
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
