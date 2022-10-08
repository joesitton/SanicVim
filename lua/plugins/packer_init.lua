local ok, packer = pcall(require, "packer")
local packer_bootstrap = nil

if not ok then
    print("Cloning packer...")

    local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

    vim.fn.delete(packer_path, "rf")

    packer_bootstrap = vim.fn.system({
        "git",
        "clone",
        "https://github.com/wbthomason/packer.nvim",
        "--depth",
        "20",
        packer_path,
    })

    vim.cmd("packadd packer.nvim")

    ok, packer = pcall(require, "packer")

    if not ok then
        error("Error installing packer.nvim!\n" .. packer_path .. "\n" .. packer)
    end
end

packer.init({
    compile_path = vim.fn.stdpath("data") .. "/site/plugin/compiled_packer.lua",
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
        prompt_border = "rounded",
        working_sym = " ",
        error_sym = "",
        done_sym = " ",
    },
    max_jobs = 12,
    git = {
        clone_timeout = 120,
    },
    autoremove = true,
})

if packer_bootstrap then
    packer.install()
end

return packer
