return {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup(opts)

        -- open / close ui windows automatically
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
            vim.cmd.NvimTreeClose({})
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
            vim.cmd.NvimTreeClose({})
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
            vim.cmd.NvimTreeOpen({})
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
            vim.cmd.NvimTreeOpen({})
        end
    end,
}
