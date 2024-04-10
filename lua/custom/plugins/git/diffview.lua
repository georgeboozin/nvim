return {
    "sindrets/diffview.nvim",
    config = function()
        local map = vim.keymap.set
        map("n", "<leader>gdo", "<cmd> DiffviewOpen<CR>", { desc = "Open git diffview" })
        map("n", "<leader>gdc", "<cmd> DiffviewClose<CR>", { desc = "Close git diffview" })
        map("n", "<leader>gdh", "<cmd> DiffviewFileHistory<CR>", { desc = "Open File History" })
    end,
}
