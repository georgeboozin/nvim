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
            vim.keymap.set("n", "<leader>hn", function()
                api.tree.toggle_custom_filter()
            end, { noremap = true, silent = false })

            local function grep_at_current_tree_node()
                local nvim_tree_api = require("nvim-tree.api")

                local node = nvim_tree_api.tree.get_node_under_cursor()
                if not node then
                    return
                end
                -- require("telescope.builtin").live_grep({ search_dirs = { node.absolute_path } })

                require("custom.plugins.telescope-pickers").prettyGrepPicker({
                    picker = "live_grep",
                    options = {
                        search_dirs = { node.absolute_path },
                    },
                })
            end

            vim.keymap.set(
                "n",
                "<leader>scg",
                grep_at_current_tree_node,
                { desc = "[S]earch under [C]ursor by [G]rep" }
            )
        end

        -- pass to setup along with your other options
        require("nvim-tree").setup({
            on_attach = my_on_attach,
            filters = {
                custom = { "node_modules" },
                git_ignored = false,
            },
            -- focus current file
            sync_root_with_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            actions = {
                open_file = {
                    resize_window = false,
                },
                change_dir = {
                    -- enable = true,
                    -- global = false,
                    restrict_above_cwd = true,
                },
            },
            view = {
                -- float = {
                --     enable = true,
                -- },
                width = {
                    min = 30,
                    max = -1,
                },
            },
            diagnostics = {
                enable = true,
            },
            modified = {
                enable = true,
            },
            -- hijack_cursor = true,
            renderer = {
                indent_width = 1,
                root_folder_label = function(path)
                    return vim.fn.fnamemodify(path, ":t")
                end,
            },
        })
        vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggle window" })

        -- custom focus file
        -- vim.keymap.set("n", "<leader>r", function()
        --     local api = require("nvim-tree.api")
        --     api.tree.find_file({ open = true, focus = false })
        -- end, { desc = "Nvimtree Toggle window" })
    end,
}
