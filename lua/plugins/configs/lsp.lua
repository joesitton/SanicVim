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

require("nvim-lsp-installer").setup()

local lsp = require("lspconfig")

local on_attach = function(client, bufnr)
    if client.name ~= "null-ls" then
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
    end

    local ok, illuminate = pcall(require, "illuminate")

    if ok then
        illuminate.on_attach(client, bufnr)
    end

    local ok, aerial = pcall(require, "aerial")

    if ok then
        aerial.on_attach(client, bufnr)
    end

    local ok, navic = pcall(require, "nvim-navic")

    if ok then
        navic.attach(client, bufnr)
    end
end

local function client_is_configured(server_name, ft)
    ft = ft or vim.bo.filetype
    local active_autocmds = vim.split(vim.fn.execute("autocmd FileType " .. ft), "\n")

    for _, result in ipairs(active_autocmds) do
        if result:match(server_name) then
            return true
        end
    end

    return false
end

local function setup_server(name)
    if client_is_configured(name, nil) then
        return
    end

    local is_avail, server = require("nvim-lsp-installer.servers").get_server(name)

    if is_avail then
        -- if not server:is_installed() then
        --     local msg = name .. " is not installed!"
        --     local ok, noti = pcall(require, "notify")
        --
        --     if ok then
        --         noti.notify(msg, "error")
        --     else
        --         vim.notify(msg, "error")
        --     end
        -- end

        local settings = {}
        local cmd = server:get_default_options().cmd

        if name == "sumneko_lua" then
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim", "packer_plugins" },
                    },
                },
            }
        elseif name == "jsonls" then
            cmd = { "vscode-json-languageserver", "--stdio" }
        end

        lsp[name].setup({
            cmd = cmd,
            settings = settings,
            capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            on_attach = on_attach,
            flags = { debounce_text_changes = 300 },
        })
    end
end

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

for _, server in ipairs(servers) do
    setup_server(server)
end
