return {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    config = function()
        local map = vim.keymap.set

        map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "window left" })
        map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "window down" })
        map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "window up" })
        map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "window right" })
    end,
}
