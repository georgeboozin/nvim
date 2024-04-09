return {
    "numToStr/Comment.nvim",
    opts = {},
    config = function()
        vim.keymap.set("n", "<leader>/", function()
            require("Comment.api").toggle.linewise.current()
        end, { desc = "Toggle commen" })
        vim.keymap.set(
            "v",
            "<leader>/",
            "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
            { desc = "Toggle commen" }
        )
    end,
}
