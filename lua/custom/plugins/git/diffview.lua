return {
    "sindrets/diffview.nvim",
    config = function()
        local map = vim.keymap.set
        map("n", "<leader>gdo", "<cmd> DiffviewOpen<CR>", { desc = "Open git diffview" })
        map("n", "<leader>gdc", "<cmd> DiffviewClose<CR>", { desc = "Close git diffview" })
        map("n", "<leader>gdh", "<cmd> DiffviewFileHistory<CR>", { desc = "Open File History" })
        require("diffview").setup({
            hooks = {
                -- TODO: figure out which hook `diff_buf_read` or `view_opened` is needed
                diff_buf_read = function(bufnr)
                    -- TODO: figure out which opt or opt_local is needed
                    vim.opt_local.foldmethod = "expr"
                    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
                    vim.opt_local.foldcolumn = "0" -- '0' or '1' is not bad
                    vim.opt_local.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the valueufo
                    vim.opt_local.foldlevelstart = 99
                    vim.opt_local.foldenable = true
                    vim.opt.foldmethod = "expr"
                    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

                    -- print("diff_buf_read!")
                end,
                view_opened = function(view)
                    -- TODO: figure out which opt or opt_local is needed
                    vim.opt_local.foldmethod = "expr"
                    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
                    vim.opt.foldmethod = "expr"
                    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
                    --
                    -- print(("A new %s was opened on tab page %d!"):format(view.class:name(), view.tabpage))
                end,
            },
        })
    end,
}
