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
		"rust_analyzer",
		"terraformls",
		"helm_ls",
		"gopls",
		"golangci_lint_ls",
	},
})

mason_lspconfig.setup_handlers({
	function(server)
		local name = server
		local settings = nil
		local init_options = nil
		local cmd = nil

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
					schemaStore = {
						enable = false,
					},
					schemas = require("schemastore").yaml.schemas(),
				},
			}
		elseif server == "pyright" then
			settings = {
				python = {
					analysis = {
						extraPaths = { "/opt/homebrew/lib/python3.*/site-packages" },
					},
				},
			}
			-- elseif server == "lua_ls" then
			-- 	settings = {
			-- 		Lua = {
			-- 			completion = {
			-- 				callSnippet = "Replace",
			-- 			},
			-- 		},
			-- 	}
		elseif server == "gopls" then
			settings = {
				gopls = {
					gofumpt = true,
				},
			}
		elseif server == "golangci_lint_ls" then
			name = "golangci"
			cmd = { "golangci-lint-langserver", "-nolintername" }
		end

		lspconfig[server].setup({
			name = name,
			cmd = cmd,
			init_options = init_options,
			on_attach = on_attach,
			settings = settings,
			capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
			flags = {
				debounce_text_changes = 300,
			},
		})
	end,
})
