local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
    local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
    config = vim.deepcopy(config)

    ---@cast args string[]
    config.args = function()
        ---@diagnostic disable-next-line: redundant-parameter
        local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
        return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
    end

    return config
end

return {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = {
        { "stevearc/overseer.nvim", opts = { dap = false } },
        -- build debugger from source
        {
            "microsoft/vscode-js-debug",
            version = "1.x",
            -- go to ~/.local/share/nvim/lazy/vscode-js-debug
            -- nvm use v14.18.2
            -- npm i
            -- npm run compile vsDebugServerBundle && mv dist out
        },
    },
    config = function()
        -- Use overseer for running preLaunchTask and postDebugTask.
        require("overseer").patch_dap(true)

        local map = vim.keymap.set
        map("n", "<leader>da", function()
            if vim.fn.filereadable(".vscode/launch.json") then
                local dap_vscode = require("dap.ext.vscode")
                dap_vscode.json_decode = require("overseer.json").decode
                dap_vscode.load_launchjs(nil, {
                    ["chrome"] = js_based_languages,
                    ["node"] = js_based_languages,
                    ["pwa-node"] = js_based_languages,
                    ["pwa-chrome"] = js_based_languages,
                    ["node-terminal"] = js_based_languages,
                })
            end
            -- require("dap").continue({ before = get_args })
            require("dap").continue()
        end, { desc = "Run with Args" })

        require("dap-vscode-js").setup({
            debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
            adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
        })
        local dap = require("dap")
        for _, language in ipairs(js_based_languages) do
            dap.configurations[language] = {
                -- Debug single nodejs files
                {
                    name = "Launch file",
                    type = "pwa-node",
                    request = "launch",
                    program = "${file}",
                    -- cwd = vim.fn.getcwd(),
                    cwd = "${workspaceFolder}",
                    sourceMaps = true,
                    sourceMapPathOverrides = {
                        ["./*"] = "${workspaceFolder}/src/*",
                    },
                },
                -- Debug nodejs processes (make sure to add --inspect when you run the process)
                {
                    name = "Attach",
                    type = "pwa-node",
                    request = "attach",
                    processId = require("dap.utils").pick_process,
                    -- cwd = vim.fn.getcwd(),
                    cwd = "${workspaceFolder}",
                    sourceMaps = true,
                },
                {
                    name = "Debug Jest Tests",
                    type = "pwa-node",
                    request = "launch",
                    runtimeExecutable = "node",
                    runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest", "--runInBand" },
                    rootPath = "${workspaceFolder}",
                    -- cwd = vim.fn.getcwd(),
                    cwd = "${workspaceFolder}",
                    console = "integratedTerminal",
                    internalConsoleOptions = "neverOpen",
                    -- args = {'${file}', '--coverage', 'false'},
                    -- sourceMaps = true,
                    -- skipFiles = {'<node_internals>/**', 'node_modules/**'},
                },
                {
                    name = "Debug Vitest Tests",
                    type = "pwa-node",
                    request = "launch",
                    cwd = vim.fn.getcwd(),
                    program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
                    args = { "run", "${file}" },
                    autoAttachChildProcesses = true,
                    smartStep = true,
                    skipFiles = { "<node_internals>/**", "node_modules/**" },
                },
                -- Debug web applications (client side)
                {
                    name = "Launch & Debug Chrome",
                    type = "pwa-chrome",
                    request = "launch",
                    url = function()
                        local co = coroutine.running()
                        return coroutine.create(function()
                            vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
                                if url == nil or url == "" then
                                    return
                                else
                                    coroutine.resume(co, url)
                                end
                            end)
                        end)
                    end,
                    webRoot = vim.fn.getcwd(),
                    protocol = "inspector",
                    sourceMaps = true,
                    userDataDir = false,

                    -- From https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/plugins/dap.lua
                    -- To test how it behaves
                    rootPath = "${workspaceFolder}",
                    cwd = "${workspaceFolder}",
                    console = "integratedTerminal",
                    internalConsoleOptions = "neverOpen",
                    sourceMapPathOverrides = {
                        ["./*"] = "${workspaceFolder}/src/*",
                    },
                },
                -- Divider for the launch.json derived configs
                {
                    name = "----- ↓ launch.json configs (if available) ↓ -----",
                    type = "",
                    request = "launch",
                },
            }
        end
    end,
}
