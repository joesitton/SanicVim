local default_plugins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(default_plugins) do
    vim.g["loaded_" .. plugin] = 1
end

local ok, packer = pcall(require, "plugins.packer_init")

if not ok then
    error("Could not load packer\n" .. packer)
end

return packer.startup({
    function(use)
        use({ "wbthomason/packer.nvim" })

        use({ "lewis6991/impatient.nvim", config = [[require("impatient")]] })

        use({ "nvim-lua/plenary.nvim" })

        use({ "nvim-lua/popup.nvim" })

        use({ "tami5/sqlite.lua" })

        use({ "antoinemadec/FixCursorHold.nvim" })

        -- }}}

        -- {{{ Colorschemes

        use({ "RRethy/nvim-base16", config = vim.cmd([[ silent! colo base16-default-dark ]]) })

        use({ "folke/lsp-colors.nvim", event = "BufRead" })

        -- }}}

        -- {{{ Filetype Specific

        use({ "lervag/vimtex", ft = "tex" })

        use({ "zeek/vim-zeek", ft = "zeek" })

        use({
            "s3rvac/vim-syntax-yara",
            config = vim.cmd([[autocmd BufNewFile,BufRead *.yar,*.yara setlocal filetype=yara]]),
            ft = "yara",
        })

        use({ "euclidianAce/BetterLua.vim", ft = "lua" })

        use({ "fatih/vim-go", ft = "go" })

        use({
            "ellisonleao/glow.nvim",
            config = [[vim.g.glow_border = "rounded"]],
            ft = "markdown",
        })

        use({
            "iamcco/markdown-preview.nvim",
            run = "cd app && npm install",
            config = [[vim.g.mkdp_auto_start = 1]],
            ft = "markdown",
        })

        use({ "sheerun/vim-polyglot", event = "VimEnter" })

        -- }}}

        -- {{{ Functionality

        use({ "tpope/vim-surround", keys = { "c", "d", "y" } })

        use({ "tpope/vim-sleuth" })

        use({ "tpope/vim-repeat" })

        use({
            "tpope/vim-fugitive",
            -- cmd = {
            --   "G",
            --   "Git",
            --   "Gdiffsplit",
            --   "Gread",
            --   "Gwrite",
            --   "Ggrep",
            --   "GMove",
            --   "GDelete",
            --   "GBrowse",
            --   "GRemove",
            --   "GRename",
            --   "Glgrep",
            --   "Gedit"
            -- },
            -- ft = "fugitive"
        })

        -- use {
        --   "goolord/alpha-nvim",
        --   config = [[require("plugins.configs.alpha")]]
        -- }

        use({
            "ethanholz/nvim-lastplace",
            config = [[require("plugins.configs.lastplace")]],
            event = "BufReadPost",
        })

        use({ "famiu/bufdelete.nvim", cmd = { "Bdelete", "Bwipeout" } })

        use({
            "jghauser/mkdir.nvim",
            config = [[require("mkdir")]],
            event = "BufWritePre",
        })

        use({ "folke/which-key.nvim", config = [[require("plugins.configs.whichkey")]] })

        use({
            "ahmedkhalf/project.nvim",
            config = [[require("project_nvim").setup({exclude_dirs = {"~/.local/*"}})]],
        })

        use({
            "nvim-telescope/telescope.nvim",
            requires = {
                { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
                "nvim-telescope/telescope-frecency.nvim",
            },
            config = [[require("plugins.configs.telescope")]],
        })

        use({ "rmagatti/auto-session", config = [[require("plugins.configs.session")]] })

        use({
            "phaazon/hop.nvim",
            config = [[require("plugins.configs.hop")]],
            event = "BufReadPost",
        })

        use({
            "max397574/better-escape.nvim",
            config = [[require("better_escape").setup()]],
            event = "InsertEnter",
        })

        use({
            "b3nj5m1n/kommentary",
            config = [[require("plugins.configs.comments")]],
            event = "BufReadPost",
        })

        use({
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            requires = { "MunifTanjim/nui.nvim" },
            config = [[require("plugins.configs.tree")]],
            event = "VimEnter",
            -- keys = "\\",
        })

        use({
            "sindrets/diffview.nvim",
            config = [[require("plugins.configs.diffview")]],
            cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        })

        -- use {
        --   "godlygeek/tabular",
        --   event = "BufReadPost"
        -- }

        use({ "michaelb/sniprun", run = "bash ./install.sh", cmd = "SnipRun" })

        use({
            "rcarriga/vim-ultest",
            requires = { "vim-test/vim-test" },
            run = { ":UpdateRemotePlugins" },
            config = [[require("plugins.configs.test")]],
        })

        -- }}}

        -- {{{ Appearance

        use({ "rktjmp/lush.nvim", config = [[require("plugins.configs.theme")]] })

        use({ "kyazdani42/nvim-web-devicons" })

        use({
            "romgrk/barbar.nvim",
            config = [[require("plugins.configs.bufferline")]],
            event = "VimEnter",
        })

        -- use({
        --     "nvim-lualine/lualine.nvim",
        --     config = [[require("plugins.configs.statusline")]],
        --     event = "VimEnter",
        -- })

        use({
            "chentoast/marks.nvim",
            config = [[require("plugins.configs.marks")]],
            event = "BufReadPost",
        })

        use({
            "norcalli/nvim-colorizer.lua",
            config = [[require("plugins.configs.colorizer")]],
        })

        use({
            "lukas-reineke/indent-blankline.nvim",
            config = [[require("plugins.configs.indentline")]],
            event = "BufReadPost",
        })

        use({
            "lewis6991/gitsigns.nvim",
            config = [[require("plugins.configs.gitsigns")]],
            event = "BufReadPost",
        })

        use({
            "karb94/neoscroll.nvim",
            config = [[require("plugins.configs.neoscroll")]],
            event = "WinScrolled",
        })

        use({
            "RRethy/vim-illuminate",
            config = [[require("plugins.configs.illuminate")]],
            event = "BufReadPost",
        })

        use({
            "beauwilliams/focus.nvim",
            config = [[require("plugins.configs.focus")]],
            cmd = "FocusEnable",
        })

        use({
            "luukvbaal/stabilize.nvim",
            config = [[require("stabilize").setup()]],
            event = "BufReadPost",
        })

        use({
            "anuvyklack/pretty-fold.nvim",
            requires = "anuvyklack/nvim-keymap-amend",
            config = [[require("plugins.configs.prettyfold")]],
            event = "BufReadPost",
        })

        use({
            "stevearc/dressing.nvim",
            config = [[require("plugins.configs.dressing")]],
            event = "VimEnter",
        })

        use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

        use({
            "folke/zen-mode.nvim",
            setup = vim.api.nvim_set_keymap("n", "<F2>", ":ZenMode<CR>", {}),
            config = [[require("plugins.configs.zenmode")]],
            cmd = "ZenMode",
        })

        use({
            "akinsho/toggleterm.nvim",
            config = [[require("plugins.configs.term")]],
            keys = "<F1>",
        })

        -- }}}

        -- {{{ Completion

        use({
            "hrsh7th/nvim-cmp",
            requires = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-calc",
                "hrsh7th/cmp-emoji",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp-document-symbol",
                "hrsh7th/cmp-nvim-lsp-signature-help",
                "petertriho/cmp-git",
                "joesitton/cmp-conventionalcommits",
                "joesitton/cmp-rg",
                "lukas-reineke/cmp-under-comparator",
                "ray-x/cmp-treesitter",
                { "tzachar/cmp-tabnine", run = "./install.sh" },
                -- {
                --   "abecodes/tabout.nvim",
                --   config = [[require("tabout").setup()]],
                --   after = "nvim-cmp"
                -- },
                { "kdheepak/cmp-latex-symbols", ft = "tex" },
                {
                    "L3MON4D3/LuaSnip",
                    requires = {
                        "saadparwaiz1/cmp_luasnip",
                        "rafamadriz/friendly-snippets",
                    },
                    config = [[require("luasnip/loaders/from_vscode").lazy_load()]],
                },
            },
            config = [[require("plugins.configs.cmp")]],
        })

        -- }}}

        -- {{{ LSP

        use({
            "j-hui/fidget.nvim",
            config = [[require("plugins.configs.fidget")]],
            event = "BufReadPost",
        })

        use({
            "jose-elias-alvarez/null-ls.nvim",
            config = [[require("plugins.configs.null-ls")]],
        })

        use({
            "williamboman/nvim-lsp-installer",
            { "neovim/nvim-lspconfig", config = [[require("plugins.configs.lsp")]] },
        })

        -- }}}

        -- {{{ Treesitter

        use({
            "nvim-treesitter/nvim-treesitter",
            requires = {
                { "p00f/nvim-ts-rainbow", event = "BufReadPre" },
                { "andymass/vim-matchup", event = "CursorMoved" },
                {
                    "windwp/nvim-autopairs",
                    config = [[require("nvim-autopairs").setup({check_ts = true})]],
                },
                {
                    "JoosepAlviste/nvim-ts-context-commentstring",
                    event = "BufReadPre",
                },
            },
            run = ":silent! TSUpdate",
            config = [[require("plugins.configs.treesitter")]],
        })
    end,
})
