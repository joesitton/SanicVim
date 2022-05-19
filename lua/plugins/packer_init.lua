vim.cmd("packadd packer.nvim")

local ok, packer = pcall(require, "packer")

if not ok then
    print("Cloning packer...")

    local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

    vim.fn.delete(packer_path, "rf")
    vim.fn.system({
        "git",
        "clone",
        "https://github.com/wbthomason/packer.nvim",
        "--depth",
        "20",
        packer_path,
    })

    vim.cmd("packadd packer.nvim")

    ok, packer = pcall(require, "packer")

    if ok then
        print("Successfully installed packer.nvim")
    else
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
    },
    git = {
        clone_timeout = 5000,
    },
    autoremove = true,
})

return packer
