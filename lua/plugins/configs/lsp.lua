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

-- require("mason-null-ls").setup({
-- 	automatic_installation = true,
-- 	automatic_setup = true,
-- 	ensure_installed = {
-- 		"black",
-- 		"isort",
-- 		"jq",
-- 		"stylua",
-- 		"yamlfmt",
-- 		"goimports",
-- 		-- "golangci_lint",
-- 	},
-- 	handlers = {},
-- })

-- local null_ls = require("null-ls")
-- null_ls.setup({
-- 	border = "rounded",
-- 	-- sources = {
-- 	-- 	null_ls.builtins.code_actions.gitsigns,
-- 	-- },
-- })

-- require("mason-nvim-dap").setup({
--     ensure_installed = { "delve" },
--     automatic_installation = true,
--     handlers = {},
-- })

require("lspconfig.ui.windows").default_options.border = "rounded"
local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
	-- Attach navic if the server is capable
	if client.server_capabilities["documentSymbolProvider"] then
		require("nvim-navic").attach(client, bufnr)
	end

	-- Disable some syntax highlighting
	if client.name == "lua_ls" then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = {
		"pyright",
		"dockerls",
		"bashls",
		"ansiblels",
		"jsonls",
		"yamlls",
		"vimls",
		"lua_ls",
		-- "rust_analyzer",
		"terraformls",
		"helm_ls",
		"gopls",
		"golangci_lint_ls",
	},
})

local default_config = {
	on_attach = on_attach,
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	flags = {
		debounce_text_changes = 250,
	},
}

for _, server in ipairs({ "dockerls", "bashls", "ansiblels", "lua_ls", "terraformls", "helm_ls", "vimls" }) do
	lspconfig[server].setup(default_config)
end

lspconfig["pyright"].setup(vim.tbl_deep_extend("force", default_config, {
	settings = {
		python = {
			analysis = {
				extraPaths = { "/opt/homebrew/lib/python3.*/site-packages" },
			},
		},
	},
}))

lspconfig["jsonls"].setup(vim.tbl_deep_extend("force", default_config, {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
}))

lspconfig["yamlls"].setup(vim.tbl_deep_extend("force", default_config, {
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
			},
			schemas = require("schemastore").yaml.schemas(),
		},
	},
}))

lspconfig["gopls"].setup(vim.tbl_deep_extend("force", default_config, {
	settings = {
		gopls = {
			gofumpt = true,
		},
	},
}))

lspconfig["golangci_lint_ls"].setup({
	name = "golangci",
	cmd = { "golangci-lint-langserver", "-nolintername" },
	filetypes = { "go", "gomod" },
	flags = {
		debounce_text_changes = 250,
	},
})
