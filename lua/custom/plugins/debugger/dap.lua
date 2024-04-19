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

        vim.api.nvim_set_hl(0, "DapBreakpointIcon", {
            ctermbg = 0,
            fg = "#ed8796",
        })
        vim.api.nvim_set_hl(0, "DapBreakpointLine", {
            ctermbg = 0,
            -- bg = "#4d4756", -- rosewater
            -- bg = "#383748", -- lighter rosewater
            -- bg = "#4c3044", -- red#1
            bg = "#4d2d41", -- red#2
        })

        vim.api.nvim_set_hl(0, "DapLogPointIcon", { ctermbg = 0, fg = "#a6da95" })
        vim.api.nvim_set_hl(0, "DapLogPointLine", {
            ctermbg = 0,
            bg = "#4b5d55", -- dgreen
            -- bg = "#3e4b4c " -- ligher green
        })

        vim.api.nvim_set_hl(0, "DapStoppedIcon", {
            ctermbg = 0,
            -- fg = "#98c379",
            fg = "#eed49f",
        })
        vim.api.nvim_set_hl(0, "DapStoppedLine", { ctermbg = 0, bg = "#48464B" })

        vim.fn.sign_define("DapBreakpoint", {
            text = "",
            texthl = "DapBreakpointIcon",
            linehl = "DapBreakpointLine",
            -- numhl = "DapBreakpoint",
        })
        vim.fn.sign_define("DapBreakpointCondition", {
            text = "ﳁ",
            texthl = "DapBreakpointIcon",
            linehl = "DapBreakpointLine",
            -- numhl = "DapBreakpoint"
        })
        vim.fn.sign_define("DapBreakpointRejected", {
            text = "",
            texthl = "DapBreakpointIcon",
            linehl = "DapBreakpointLine",
            --numhl = "DapBreakpoint"
        })
        vim.fn.sign_define(
            "DapLogPoint",
            { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
        )
        vim.fn.sign_define("DapStopped", {
            text = "",
            texthl = "DapStoppedIcon",
            linehl = "DapStoppedLine",
            -- numhl = "DapStopped"
        })
    end,
}
