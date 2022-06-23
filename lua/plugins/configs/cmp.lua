local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

require("cmp_git").setup()

local tabnine = require("cmp_tabnine.config")

tabnine:setup({
    max_lines = 500,
    max_num_results = 10,
    sort = false,
    run_on_every_keystroke = false,
    snippet_placeholder = "..",
    ignored_file_types = {},
    show_prediction_strength = false,
})

local symbol_map = {
    Text = " ",
    Method = " ",
    Function = " ",
    Constructor = "⌘ ",
    Field = " ",
    Variable = " ",
    Class = "ﴯ ",
    Interface = " ",
    Module = " ",
    Property = " ",
    Unit = "塞 ",
    Value = " ",
    Enum = " ",
    Keyword = "廓",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = " ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = "פּ ",
    Event = " ",
    Operator = " ",
    TypeParameter = "",
}

local menu = {
    buffer = "Buffer",
    path = "Path",
    nvim_lsp = "LSP",
    nvim_lua = "Lua",
    luasnip = "Snippet",
    latex_symbols = "LaTeX",
    rg = "Ripgrep",
    calc = "Calc",
    treesitter = "TreeSitter",
    emoji = "Emoji",
    conventionalcommits = "Commit",
    cmdline_history = "History",
    git = "Git",
    cmp_tabnine = "TabNine",
    copilot = "Copilot",
}

cmp.setup({
    experimental = {
        native_menu = false,
        ghost_text = {
            hl_group = "CmpGhostText",
        },
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.menu = menu[entry.source.name]
            vim_item.kind = symbol_map[vim_item.kind]

            if entry.source.name == "cmp_tabnine" then
                vim_item.kind = " "
            elseif entry.source.name == "copilot" then
                vim_item.kind = " "
            end

            return vim_item
        end,
    },
    window = {
        completion = {
            border = "rounded",
            winhighlight = "Pmenu:FloatBorder",
        },
        documentation = {
            border = "rounded",
            winhighlight = "Pmenu:FloatBorder",
            winblend = 3,
        },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<ESC>"] = cmp.mapping(function(fallback)
            cmp.abort()
            fallback()
        end),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-Space>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.close()
            elseif not cmp.visible() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "calc" },
        { name = "emoji" },
        -- { name = "buffer" },
        { name = "treesitter" },
        { name = "latex_symbols" },
        { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "nvim_lsp_signature_help" },
        { name = "cmp_tabnine" },
        -- { name = "copilot" },
    },
    sorting = {
        comparators = {
            require("cmp_tabnine.compare"),
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require("cmp-under-comparator").under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
})

cmp.setup.cmdline(":", {
    view = { entries = { name = "custom", selection_order = "near_cursor" } },
    formatting = { fields = { "abbr" } },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

for _, cmdtype in ipairs({ "?", "/" }) do
    cmp.setup.cmdline(cmdtype, {
        view = { entries = { name = "custom", selection_order = "near_cursor" } },
        formatting = { fields = { "abbr" } },
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            {
                name = "rg",
                option = {
                    additional_arguments = "--smart-case",
                    only_current_buffer = true,
                },
            },
        }),
    })
end

cmp.setup.filetype("gitcommit", {
    formatting = { fields = { "kind", "abbr" } },
    sources = {
        { name = "conventionalcommits" },
        { name = "git" },
    },
})
