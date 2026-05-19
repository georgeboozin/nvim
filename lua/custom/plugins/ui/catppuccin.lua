return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            lavour = "mocha",
        })
        vim.cmd.colorscheme("catppuccin-mocha")
    end,
}
