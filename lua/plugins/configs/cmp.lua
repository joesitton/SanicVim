local ok, cmp = pcall(require, "cmp")

if not ok then
    error("Could not load cmp: " .. cmp)
    return
end

local ok, autopairs = pcall(require, "nvim-autopairs.completion.cmp")

if ok then
    cmp.event:on("confirm_done", autopairs.on_confirm_done({ map_char = { tex = "" } }))
end

local ok, cmp_git = pcall(require, "cmp_git")

if ok then
    cmp_git.setup()
end

local ok, tabnine = pcall(require, "cmp_tabnine.config")

if ok then
    tabnine:setup({
        max_lines = 500,
        max_num_results = 2,
        sort = false,
        run_on_every_keystroke = false,
        snippet_placeholder = "..",
        ignored_file_types = {},
        show_prediction_strength = false,
    })
end

local symbol_map = require("core.utils").symbols

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
    neorg = "Neorg",
}

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")

cmp.setup({
    enabled = function()
        local ft = vim.bo.filetype

        if ft == "TelescopePrompt" or ft == "neo-tree-popup" then
            return false
        end

        local context = require("cmp.config.context")

        if vim.api.nvim_get_mode().mode == "c" then
            return true
        else
            return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
        end
    end,
    view = {
        entries = {
            name = "custom",
            selection_order = "near_cursor",
        },
    },
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
                vim_item.kind = "   "
            elseif entry.source.name == "copilot" then
                vim_item.kind = "  "
            end

            return vim_item
        end,
    },
    window = {
        completion = {
            col_offset = -4,
            side_padding = 0,
            -- border = "rounded",
            -- winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder",
        },
        documentation = {
            -- border = "rounded",
            winhighlight = "Normal:Pmenu",
        },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
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
        { name = "nvim_lua" },
        { name = "path" },
        { name = "calc" },
        -- { name = "emoji" },
        { name = "buffer" },
        { name = "treesitter" },
        { name = "latex_symbols" },
        { name = "luasnip" },
        { name = "cmp_tabnine" },
        { name = "nvim_lsp_signature_help" },
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
    window = { completion = { side_padding = 1, col_offset = 0 } },
    formatting = { fields = { "abbr" } },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

for _, cmdtype in ipairs({ "?", "/" }) do
    cmp.setup.cmdline(cmdtype, {
        view = { entries = { name = "custom", selection_order = "near_cursor" } },
        window = { completion = { side_padding = 1, col_offset = 0 } },
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
            {
                name = "nvim_lsp_document_symbol",
            },
        }),
    })
end

cmp.setup.filetype("gitcommit", {
    formatting = { fields = { "kind", "abbr" } },
    window = { completion = { side_padding = 1, col_offset = 0 } },
    sources = cmp.config.sources({
        { name = "git" },
    }),
})

cmp.setup.filetype("norg", {
    window = { completion = { side_padding = 1, col_offset = 0 } },
    sources = cmp.config.sources({
        { name = "neorg" },
        {
            name = "rg",
            option = {
                additional_arguments = "--smart-case",
                only_current_buffer = true,
            },
        },
    }),
})
