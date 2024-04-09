return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            lavour = "macchiato",
        })
        vim.cmd.colorscheme("catppuccin-macchiato")
    end,
}
