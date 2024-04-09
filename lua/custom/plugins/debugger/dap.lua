return {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui" },
    config = function()
        local map = vim.keymap.set

        map("n", "<leader>dd", function()
            vim.cmd.RustLsp("debuggables")
        end, { desc = "Start debugging" })

        map("n", "<leader>db", function()
            require("dap").toggle_breakpoint()
        end, { desc = "Toggle breakpoint" })

        map("n", "<leader>du", function()
            require("dapui").toggle()
        end, { desc = "Toggle debugging interface" })

        map("n", "<leader>dc", function()
            require("dap").terminate()
            require("dapui").close()
        end, { desc = "Terminate debugging" })

        map("n", "<F5>", function()
            require("dapui").open()
            vim.cmd.RustLsp("debuggables")
        end, { desc = "Start debugging" })

        map("n", "<F10>", function()
            require("dap").step_over()
        end, { desc = "Step over" })

        map("n", "<F11>", function()
            require("dap").step_into()
        end, { desc = "Step into" })
        map("n", "<F12>", function()
            require("dap").step_out()
        end, { desc = "Step out" })

        -- map("n", "<tab>", "<cmd>BufferNext<CR>", { desc = "Buffer Goto next" })
    end,
}
