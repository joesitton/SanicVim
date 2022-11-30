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

    -- }}}

    -- {{{ Colorschemes

    {
        "~/Dev/lush-base16",
        requires = { "rktjmp/lush.nvim" },
        config = vim.cmd([[ silent! colo lush-base16 ]]),
    },

    -- }}}

    -- {{{ Filetype Support

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
        config = vim.cmd([[autocmd BufNewFile,BufRead *.yara setlocal filetype=yara]]),
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
        "baskerville/vim-sxhkdrc",
        ft = "sxhkdrc",
    },

    {
        "towolf/vim-helm",
        config = vim.cmd([[autocmd BufNewFile,BufRead *.{yaml,yml}.template setlocal filetype=helm]]),
        ft = "helm",
    },

    -- }}}

    -- {{{ Functionality

    {
        "tpope/vim-surround",
        event = "BufReadPost",
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
    },

    -- {
    --     "famiu/nvim-reload",
    -- },

    {
        "fedepujol/move.nvim",
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

    -- {
    --     "ziontee113/icon-picker.nvim",
    --     config = [[require("icon-picker")]],
    --     cmd = { "PickEverything", "PickEverythingInsert" },
    -- },

    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
                config = [[require("telescope").load_extension("fzf")]],
                after = "telescope.nvim",
            },
            {
                "gbrlsnchs/telescope-lsp-handlers.nvim",
                config = [[require("telescope").load_extension("lsp_handlers")]],
                after = "telescope.nvim",
            },
            {
                "olacin/telescope-gitmoji.nvim",
                config = [[require("telescope").load_extension("gitmoji")]],
                after = "telescope.nvim",
            },
            {
                "benfowler/telescope-luasnip.nvim",
                config = [[require("telescope").load_extension("luasnip")]],
                after = "telescope.nvim",
            },
            {
                "ahmedkhalf/project.nvim",
                config = [[
                    require("project_nvim").setup({ exclude_dirs = { "~/.local/*" }, silent_chdir = false })
                    require("telescope").load_extension("projects")
                ]],
                after = "telescope.nvim",
            },
            {
                "AckslD/nvim-neoclip.lua",
                requires = "kkharji/sqlite.lua",
                config = [[
                    require("plugins.configs.neoclip")
                    require("telescope").load_extension("neoclip")
                ]],
                after = "telescope.nvim",
            },
            {
                "ThePrimeagen/harpoon",
                config = [[
                    require("harpoon").setup({})
                    require("telescope").load_extension("harpoon")
                ]],
                after = "telescope.nvim",
            },
            {
                "stevearc/aerial.nvim",
                config = [[
                    require("plugins.configs.aerial")
                    require("telescope").load_extension("aerial")
                ]],
                after = "telescope.nvim",
            },
            {
                "rcarriga/nvim-notify",
                config = [[
                    require("notify").setup({background_colour = "#181818", render = "minimal" })
                    require("telescope").load_extension("notify")
                    vim.notify = require("notify")
                ]],
            },
            -- {
            --     "ThePrimeagen/refactoring.nvim",
            --     config = [[
            --         require("refactoring").setup()
            --         require("telescope").load_extension("refactoring")
            --     ]],
            --     after = "telescope.nvim",
            -- },
            {
                "olimorris/persisted.nvim",
                config = [[
                    require("plugins.configs.session")
                    require("telescope").load_extension("persisted")
                ]],
                after = { "telescope.nvim", "nvim-notify" },
            },
        },
        config = [[require("plugins.configs.telescope")]],
        event = "VimEnter",
    },

    {
        "phaazon/hop.nvim",
        branch = "v2",
        config = [[require("hop").setup({ teasing = false })]],
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
        requires = { "MunifTanjim/nui.nvim", event = "UIEnter" },
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

    -- {
    --     "michaelb/sniprun",
    --     run = "bash ./install.sh",
    --     cmd = "SnipRun",
    -- },

    -- {
    --     "nvim-neotest/neotest",
    --     config = [[require("plugins.configs.test")]],
    -- },

    {
        "pwntester/octo.nvim",
        config = [[require("octo").setup()]],
    },

    {
        "nvim-neorg/neorg",
        config = [[require("plugins.configs.neorg")]],
        ft = "norg",
        after = "nvim-treesitter",
    },

    {
        "smjonas/inc-rename.nvim",
        config = [[require("inc_rename").setup()]],
    },

    -- }}}

    -- {{{ Appearance

    {
        "kyazdani42/nvim-web-devicons",
        event = "VimEnter",
    },

    {
        "romgrk/barbar.nvim",
        config = [[require("plugins.configs.barbar")]],
        after = { "nvim-web-devicons" },
        event = "VimEnter",
    },

    -- {
    --     "nanozuki/tabby.nvim",
    --     config = [[require("plugins.configs.tabby")]],
    --     event = "VimEnter",
    -- },

    -- {
    --     "utilyre/barbecue.nvim",
    --     requires = {
    --         "nvim-lspconfig",
    --         "smiteshp/nvim-navic",
    --     },
    --     config = [[require("barbecue").setup({ kinds = require("core.utils").symbols })]]
    -- },

    {
        "feline-nvim/feline.nvim",
        after = "lush-base16",
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
        "kevinhwang91/nvim-ufo",
        requires = "kevinhwang91/promise-async",
        config = [[require("plugins.configs.ufo")]],
        event = "BufReadPost",
    },

    {
        "stevearc/dressing.nvim",
        config = [[require("plugins.configs.dressing")]],
        event = "UIEnter",
    },

    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },

    {
        "folke/zen-mode.nvim",
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
        config = [[require("plugins.configs.scrollbar")]],
        event = "BufReadPost",
    },

    -- {
    --     "xiyaowong/virtcolumn.nvim",
    --     config = [[vim.g.virtcolumn_char = '▕']],
    -- },

    {
        "anuvyklack/windows.nvim",
        requires = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim",
        },
        config = [[
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            require("windows").setup()
        ]],
    },

    {
        "kevinhwang91/nvim-hlslens",
        config = [[require("plugins.configs.hlslens")]],
        keys = { "/", "?", "*", "#", "n", "N" },
    },

    {
        "amrbashir/nvim-docs-view",
        config = [[require("docs-view").setup({position = "bottom" })]],
        cmd = { "DocsViewToggle" },
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
            -- {
            --     "hrsh7th/cmp-emoji",
            --     event = "InsertEnter",
            -- },
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
                event = { "InsertEnter", "CmdlineEnter" },
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
                config = [[require("luasnip.loaders.from_vscode").lazy_load()]],
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
                "kdheepak/cmp-latex-symbols",
                ft = "tex",
            },
            {
                "abecodes/tabout.nvim",
                config = [[require("tabout").setup({tabkey = "", backwards_tabkey = ""})]],
                after = { "nvim-cmp", "nvim-treesitter" },
            },
            {
                "lukas-reineke/cmp-under-comparator",
            },
        },
        config = [[require("plugins.configs.cmp")]],
        after = { "cmp-under-comparator", "cmp-tabnine", "cmp-nvim-lsp" },
        event = { "InsertEnter", "CmdlineEnter" },
    },

    -- }}}

    -- {{{ LSP

    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jayp0521/mason-null-ls.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        "b0o/SchemaStore.nvim",
        {
            "neovim/nvim-lspconfig",
            config = [[require("plugins.configs.lsp")]],
            after = { "cmp-nvim-lsp" },
            event = "BufReadPost",
        },
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
                "p00f/nvim-ts-rainbow",
                event = "BufReadPost",
            },
            {
                "andymass/vim-matchup",
                event = "CursorMoved",
            },
            {
                "nvim-treesitter/nvim-treesitter-context",
                config = [[require("treesitter-context").setup({ max_lines = 3 })]],
                event = "WinScrolled",
            },
            {
                "windwp/nvim-autopairs",
                config = [[require("plugins.configs.autopairs")]],
                event = "InsertEnter",
            },
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                event = "BufReadPost",
            },
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                event = "BufReadPost",
            },
            {
                "nvim-treesitter/playground",
                cmd = "TSPlaygroundToggle",
            },
            {
                "lewis6991/spellsitter.nvim",
                config = [[require("spellsitter").setup()]],
                event = "BufReadPost",
            },
            {
                "RRethy/nvim-treesitter-textsubjects",
                event = "BufReadPost",
            },
            {
                "ziontee113/syntax-tree-surfer",
                config = [[require("syntax-tree-surfer").setup()]],
                event = "BufReadPost",
            },
            {
                "m-demare/hlargs.nvim",
                config = [[require("plugins.configs.hlargs")]],
                event = "BufReadPost",
            },
            -- {
            --     "haringsrob/nvim_context_vt",
            --     config = [[require('nvim_context_vt').setup()]],
            --     event = "BufReadPost"
            -- }
        },
        run = ":silent! TSUpdate",
        config = [[require("plugins.configs.treesitter")]],
        event = "BufReadPost",
    },

    -- }}}
}

return plugins
