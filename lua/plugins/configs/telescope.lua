local status_ok, actions = pcall(require, "telescope.actions")

if not status_ok then
    return
end

local telescope = require("telescope")

telescope.setup({
    defaults = {
        prompt_prefix = "❯ ",
        multi_icon = "• ",
        -- dynamic_preview_title = true,
        treesitter = true,
        selection_caret = "  ",
        scroll_strategy = "limit",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            height = 0.8,
            width = 0.8,
            prompt_position = "top",
        },
        border = true,
        results_title = "",
        preview_title = "",
        prompt_title = "",
        borderchars = {
            results = { " ", " ", " ", " ", " ", " ", " ", " " },
            prompt = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
            preview = { " ", " ", " ", " ", " ", " ", " ", " " },
        },
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<Tab>"] = actions.move_selection_next,
                ["<S-Tab>"] = actions.move_selection_previous,
                ["<CR>"] = actions.select_default + actions.center,
                ["<ESC>"] = actions.close,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
        },
        file_ignore_patterns = {
            "node_modules",
            ".git/",
            "dist/",
            "venv",
            "env",
            ".venv",
            ".env",
            "__pycache__",
            ".tox",
        },
        use_less = true,
    },
    pickers = {
        find_files = {
            find_command = {
                "fd",
                "--type=f",
                "--strip-cwd-prefix",
                "--hidden",
            },
        },
    },
    extensions = {
        aerial = {
            show_nesting = true,
        },
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        gitmoji = {
            action = function(entry)
                vim.ui.input({ prompt = entry.value .. " Commit: " }, function(msg)
                    if not msg then
                        return
                    end

                    local git_tool = ":!git"

                    if vim.g.loaded_fugitive then
                        git_tool = ":G"
                    end

                    vim.cmd(string.format('%s commit -m "%s %s"', git_tool, entry.value, msg))
                end)
            end,
        },
    },
})
