local plugins = {
    -- {{{ Core
    {
        "wbthomason/packer.nvim",
    },

    {
        "lewis6991/impatient.nvim",
        config = [[require("impatient")]],
    },

    {
        "nvim-lua/plenary.nvim",
    },

    {
        "nvim-lua/popup.nvim",
    },

    {
        "antoinemadec/FixCursorHold.nvim",
    },

    {
        "rcarriga/nvim-notify",
        config = [[require("notify").setup({background_colour = "#181818" })]],
        event = "VimEnter",
    },

    -- }}}

    -- {{{ Colorschemes

    {
        "~/Downloads/lush-base16",
        requires = { "rktjmp/lush.nvim" },
        config = vim.cmd([[ silent! colo lush-base16 ]]),
    },

    -- }}}

    -- {{{ Filetype Specific

    {
        "lervag/vimtex",
        ft = "tex",
    },

    {
        "zeek/vim-zeek",
        ft = "zeek",
    },

    {
        "s3rvac/vim-syntax-yara",
        config = vim.cmd([[autocmd BufNewFile,BufRead *.yar,*.yara setlocal filetype=yara]]),
        ft = "yara",
    },

    {
        "euclidianAce/BetterLua.vim",
        ft = "lua",
    },

    {
        "fatih/vim-go",
        ft = "go",
    },

    {
        "ellisonleao/glow.nvim",
        config = [[vim.g.glow_border = "rounded"]],
        ft = "markdown",
    },

    {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        config = [[vim.g.mkdp_auto_start = 1]],
        ft = "markdown",
    },

    -- {
    --     "sheerun/vim-polyglot",
    --     event = "BufReadPost",
    -- },

    -- }}}

    -- {{{ Functionality

    {
        "tpope/vim-surround",
        keys = { "c", "d", "y" },
    },

    {
        "tpope/vim-sleuth",
        event = "BufReadPost",
    },

    {
        "tpope/vim-repeat",
        event = "BufReadPost",
    },

    {
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
    },

    {
        "goolord/alpha-nvim",
        config = [[require("plugins.configs.alpha")]],
        event = "VimEnter",
    },

    {
        "ethanholz/nvim-lastplace",
        config = [[require("plugins.configs.lastplace")]],
        event = "BufReadPost",
    },

    {
        "famiu/bufdelete.nvim",
        cmd = { "Bdelete", "Bwipeout" },
    },

    {
        "jghauser/mkdir.nvim",
        config = [[require("mkdir")]],
        event = "BufWritePre",
    },

    {
        "folke/which-key.nvim",
        config = [[require("plugins.configs.whichkey")]],
        event = "VimEnter",
    },

    {
        "nvim-telescope/telescope.nvim",
        requires = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
            },
            {
                "gbrlsnchs/telescope-lsp-handlers.nvim",
            },
            {
                "olacin/telescope-gitmoji.nvim",
            },
            {
                "benfowler/telescope-luasnip.nvim",
            },
            {
                "ahmedkhalf/project.nvim",
                config = [[require("plugins.configs.projects")]],
            },
            {
                "AckslD/nvim-neoclip.lua",
                requires = "tami5/sqlite.lua",
                config = [[require("neoclip").setup({enable_persistent_history = true })]],
            },
            -- {
            --     "nvim-telescope/telescope-frecency.nvim",
            --     requires = "tami5/sqlite.lua",
            -- },
        },
        config = [[require("plugins.configs.telescope")]],
        event = "VimEnter",
    },

    {
        "rmagatti/auto-session",
        config = [[require("plugins.configs.session")]],
    },

    {
        "phaazon/hop.nvim",
        config = [[require("plugins.configs.hop")]],
        event = "BufReadPost",
    },

    {
        "max397574/better-escape.nvim",
        config = [[require("better_escape").setup()]],
        event = "InsertEnter",
    },

    {
        "numToStr/Comment.nvim",
        -- requires = {
        --     "s1n7ax/nvim-comment-frame",
        --     requires = "nvim-treesitter",
        --     event = "BufReadPost",
        -- },
        config = [[require("plugins.configs.comments")]],
        event = "BufReadPost",
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = { "MunifTanjim/nui.nvim" },
        config = [[require("plugins.configs.tree")]],
        cmd = { "NeoTreeFloatToggle", "Neotree" },
    },

    {
        "sindrets/diffview.nvim",
        config = [[require("plugins.configs.diffview")]],
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    },

    {
        "godlygeek/tabular",
        event = "BufReadPost",
    },

    {
        "michaelb/sniprun",
        run = "bash ./install.sh",
        cmd = "SnipRun",
    },

    {
        "nvim-neotest/neotest",
        config = [[require("plugins.configs.test")]],
    },

    -- }}}

    -- {{{ Appearance

    {
        "kyazdani42/nvim-web-devicons",
        event = "VimEnter",
    },

    {
        "romgrk/barbar.nvim",
        config = [[require("plugins.configs.bufferline")]],
        after = { "nvim-web-devicons" },
        event = "VimEnter",
    },

    {
        "feline-nvim/feline.nvim",
        config = [[require("plugins.configs.feline")]],
        event = "VimEnter",
    },

    {
        "chentoast/marks.nvim",
        config = [[require("plugins.configs.marks")]],
        event = "BufReadPost",
    },

    {
        "norcalli/nvim-colorizer.lua",
        config = [[require("plugins.configs.colorizer")]],
        event = "BufReadPost",
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = [[require("plugins.configs.indentline")]],
        event = "BufReadPost",
    },

    {
        "lewis6991/gitsigns.nvim",
        config = [[require("plugins.configs.gitsigns")]],
        event = "BufReadPost",
    },

    {
        "karb94/neoscroll.nvim",
        config = [[require("plugins.configs.neoscroll")]],
        event = "WinScrolled",
    },

    {
        "RRethy/vim-illuminate",
        config = [[require("plugins.configs.illuminate")]],
        event = "BufReadPost",
    },

    {
        "beauwilliams/focus.nvim",
        config = [[require("plugins.configs.focus")]],
        cmd = "FocusEnable",
    },

    {
        "luukvbaal/stabilize.nvim",
        config = [[require("stabilize").setup()]],
        event = "BufReadPost",
    },

    {
        "anuvyklack/pretty-fold.nvim",
        requires = "anuvyklack/nvim-keymap-amend",
        config = [[require("plugins.configs.prettyfold")]],
        event = "BufReadPost",
    },

    {
        "stevearc/dressing.nvim",
        config = [[require("plugins.configs.dressing")]],
        event = "VimEnter",
    },

    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },

    {
        "folke/zen-mode.nvim",
        setup = vim.keymap.set("n", "<F2>", ":ZenMode<CR>"),
        config = [[require("plugins.configs.zenmode")]],
        cmd = "ZenMode",
    },

    {
        "akinsho/toggleterm.nvim",
        tag = "v1.*",
        config = [[require("plugins.configs.term")]],
    },

    {
        "petertriho/nvim-scrollbar",
        requires = { "kevinhwang91/nvim-hlslens", keys = { "/", "?" } },
        config = [[require("plugins.configs.scrollbar")]],
    },

    -- }}}

    -- {{{ Completion

    {
        "hrsh7th/nvim-cmp",
        requires = {
            {
                "hrsh7th/cmp-nvim-lsp",
                event = "InsertEnter",
            },
            {
                "hrsh7th/cmp-calc",
                event = "InsertEnter",
            },
            {
                "hrsh7th/cmp-emoji",
                event = "InsertEnter",
            },
            {
                "hrsh7th/cmp-path",
                event = { "InsertEnter", "CmdlineEnter" },
            },
            {
                "hrsh7th/cmp-cmdline",
                event = { "InsertEnter", "CmdlineEnter" },
            },
            {
                "hrsh7th/cmp-buffer",
                event = "InsertEnter",
            },
            {
                "hrsh7th/cmp-nvim-lua",
                event = "InsertEnter",
            },
            {
                "hrsh7th/cmp-nvim-lsp-document-symbol",
                event = "InsertEnter",
            },
            {
                "hrsh7th/cmp-nvim-lsp-signature-help",
                event = "InsertEnter",
            },
            {
                "joesitton/cmp-rg",
                event = { "InsertEnter", "CmdlineEnter" },
            },
            {
                "tzachar/cmp-tabnine",
                run = "./install.sh",
                event = "InsertEnter",
            },
            {
                "L3MON4D3/LuaSnip",
                requires = {
                    {
                        "saadparwaiz1/cmp_luasnip",
                        event = "InsertEnter",
                    },
                    {
                        "rafamadriz/friendly-snippets",
                        event = "InsertEnter",
                    },
                },
                config = [[require("luasnip/loaders/from_vscode").lazy_load()]],
                event = "InsertEnter",
            },
            {
                "ray-x/cmp-treesitter",
                after = "nvim-treesitter",
                event = "InsertEnter",
            },
            {
                "petertriho/cmp-git",
                ft = "gitcommit",
            },
            {
                "joesitton/cmp-conventionalcommits",
                ft = "gitcommit",
            },
            {
                "kdheepak/cmp-latex-symbols",
                ft = "tex",
            },
            {
                "abecodes/tabout.nvim",
                config = [[require("tabout").setup({tabkey = '', backwards_tabkey = ''})]],
                after = { "nvim-cmp", "nvim-treesitter" },
            },
            {
                "lukas-reineke/cmp-under-comparator",
            },
        },
        config = [[require("plugins.configs.cmp")]],
        after = { "cmp-under-comparator", "cmp-tabnine" },
        event = { "InsertEnter", "CmdlineEnter" },
    },

    -- }}}

    -- {{{ LSP

    {
        "williamboman/nvim-lsp-installer",
        {
            "neovim/nvim-lspconfig",
            config = [[require("plugins.configs.lsp")]],
            after = { "null-ls.nvim", "cmp-nvim-lsp", "nvim-lsp-installer" },
            event = "BufReadPost",
        },
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        config = [[require("plugins.configs.null-ls")]],
        event = "BufReadPost",
    },

    {
        "j-hui/fidget.nvim",
        config = [[require("plugins.configs.fidget")]],
        event = "BufReadPost",
    },

    -- }}}

    -- {{{ Treesitter

    {
        "nvim-treesitter/nvim-treesitter",
        requires = {
            {
                "nvim-treesitter/playground",
                cmd = "TSPlaygroundToggle",
            },
            {
                "p00f/nvim-ts-rainbow",
                event = "BufReadPost",
            },
            {
                "andymass/vim-matchup",
                event = "CursorMoved",
            },
            {
                "windwp/nvim-autopairs",
                config = [[require("nvim-autopairs").setup({check_ts = true})]],
                event = "BufReadPost",
            },
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                event = "BufReadPost",
            },
        },
        run = ":silent! TSUpdate",
        config = [[require("plugins.configs.treesitter")]],
        event = "BufReadPost",
    },

    -- }}}
}

return plugins
