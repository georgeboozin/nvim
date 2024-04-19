return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local function my_on_attach(bufnr)
            local api = require("nvim-tree.api")

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- custom mappings
            vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        end

        -- pass to setup along with your other options
        require("nvim-tree").setup({
            on_attach = my_on_attach,
            filters = {
                git_ignored = false,
            },
        })
        vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggle window" })
    end,
}
