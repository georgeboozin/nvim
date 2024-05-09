return {
    "romgrk/barbar.nvim",
    dependencies = {
        "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
        "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
        vim.g.barbar_auto_setup = false
    end,
    config = function()
        require("barbar").setup({
            animation = false,
            sidebar_filetypes = {
                -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
                NvimTree = true,
                -- Or, specify the text used for the offset:
                undotree = {
                    text = "undotree",
                    align = "center", -- *optionally* specify an alignment (either 'left', 'center', or 'right')
                },
                -- Or, specify the event which the sidebar executes when leaving:
                ["neo-tree"] = { event = "BufWipeout" },
                -- Or, specify all three
                Outline = { event = "BufWinLeave", text = "symbols-outline", align = "right" },
            },
        })
        local map = vim.keymap.set

        -- map("n", "<leader>b", "<cmd>enew<CR>", { desc = "Buffer New" })
        map("n", "<leader>bc", "<cmd>BufferCloseAllButCurrent<CR>", { desc = "Buffer Close All but not current" })

        map("n", "<tab>", "<cmd>BufferNext<CR>", { desc = "Buffer Goto next" })

        map("n", "<S-tab>", "<cmd>BufferPrevious<CR>", { desc = "Buffer Goto prev" })

        map("n", "<leader>x", "<cmd>BufferClose<CR>", { desc = "Buffer Close" })

        local opts = { noremap = true, silent = true }
        -- Move to previous/next
        map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
        map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
        -- Re-order to previous/next
        map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
        map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
    end,
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
}
