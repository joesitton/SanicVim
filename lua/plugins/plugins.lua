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
        "tami5/sqlite.lua",
    },

    {
        "antoinemadec/FixCursorHold.nvim",
        event = "VimEnter",
    },

    -- }}}

    -- {{{ Colorschemes

    {
        "RRethy/nvim-base16",
        config = vim.cmd([[ silent! colo base16-default-dark ]]),
    },

    {
        "folke/lsp-colors.nvim",
        event = "BufRead",
    },

    -- }}}

    -- {{{ Filetype Specific

    {
        "lervag/vimtex",
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

    {
        "sheerun/vim-polyglot",
        event = "VimEnter",
    },

    -- }}}

    -- {{{ Functionality

    {
        "tpope/vim-surround",
        keys = { "c", "d", "y" },
    },

    {
        "tpope/vim-sleuth",
    },

    {
        "tpope/vim-repeat",
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
    },

    {
        "ahmedkhalf/project.nvim",
        config = [[require("plugins.configs.projects")]],
    },

    {
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            "nvim-telescope/telescope-frecency.nvim",
        },
        config = [[require("plugins.configs.telescope")]],
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
        "b3nj5m1n/kommentary",
        config = [[require("plugins.configs.comments")]],
        event = "BufReadPost",
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = { "MunifTanjim/nui.nvim" },
        config = [[require("plugins.configs.tree")]],
        event = "VimEnter",
        -- keys = "\\",
    },

    {
        "sindrets/diffview.nvim",
        config = [[require("plugins.configs.diffview")]],
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    },

    -- use {
    --   "godlygeek/tabular",
    --   event = "BufReadPost"
    -- }

    {
        "michaelb/sniprun",
        run = "bash ./install.sh",
        cmd = "SnipRun",
    },

    {
        "rcarriga/vim-ultest",
        requires = { "vim-test/vim-test" },
        run = { ":UpdateRemotePlugins" },
        config = [[require("plugins.configs.test")]],
    },

    -- }}}

    -- {{{ Appearance

    {
        "rktjmp/lush.nvim",
        config = [[require("plugins.configs.theme")]],
    },

    {
        "kyazdani42/nvim-web-devicons",
    },

    {
        "romgrk/barbar.nvim",
        config = [[require("plugins.configs.bufferline")]],
        event = "VimEnter",
    },

    {
        "feline-nvim/feline.nvim",
        config = [[require("plugins.configs.statusline")]],
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
        setup = vim.api.nvim_set_keymap("n", "<F2>", ":ZenMode<CR>", {}),
        config = [[require("plugins.configs.zenmode")]],
        cmd = "ZenMode",
    },

    {
        "akinsho/toggleterm.nvim",
        config = [[require("plugins.configs.term")]],
        keys = "<F1>",
    },

    -- }}}

    -- {{{ Completion

    {
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
    },

    -- }}}

    -- {{{ LSP

    {
        "j-hui/fidget.nvim",
        config = [[require("plugins.configs.fidget")]],
        event = "BufReadPost",
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        config = [[require("plugins.configs.null-ls")]],
    },

    {
        "williamboman/nvim-lsp-installer",
        { "neovim/nvim-lspconfig", config = [[require("plugins.configs.lsp")]] },
    },

    -- }}}

    -- {{{ Treesitter

    {
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
    },

    -- }}}
}

return plugins
