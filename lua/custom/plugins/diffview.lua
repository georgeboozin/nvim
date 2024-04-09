return {
    "lewis6991/gitsigns.nvim",
    dependencies = {
        {
            "sindrets/diffview.nvim",
            config = true,
        },
    },
    config = function()
        local map = vim.keymap.set
        map("n", "<leader>gdd", "<cmd> DiffviewOpen<CR>", { desc = "Open git diffview" })
        map("n", "<leader>gdc", "<cmd> DiffviewClose<CR>", { desc = "Close git diffview" })
    end,
}
