local function first(bufnr, ...)
    local conform = require("conform")
    for i = 1, select("#", ...) do
        local formatter = select(i, ...)
        if conform.get_formatter_info(formatter, bufnr).available then
            return formatter
        end
    end
    return select(1, ...)
end

return {
    "stevearc/conform.nvim",
    lazy = false,
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "[F]ormat buffer",
        },
    },
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = {
                c = true,
                cpp = true, --[[ js = true, jsx = true, ts = true, tsx = true, mjs = true, cjs = true ]]
            }
            return {
                timeout_ms = 500,
                lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
            }
        end,
        formatters_by_ft = {
            lua = { "stylua" },
            -- Conform can also run multiple formatters sequentially
            -- python = { "isort", "black" },
            --
            -- You can use a sub-list to tell conform to run *until* a formatter
            -- is found.
            javascript = function(bufnr)
                return { first(bufnr, "prettierd"), "injected" }
            end,
            typescript = function(bufnr)
                return { first(bufnr, "prettierd"), "injected" }
            end,
            javascriptreact = function(bufnr)
                return { first(bufnr, "prettierd"), "injected" }
            end,
            typescriptreact = function(bufnr)
                return { first(bufnr, "prettierd"), "injected" }
            end,
            html = function(bufnr)
                return { first(bufnr, "prettierd"), "injected" }
            end,
            json = function(bufnr)
                return { first(bufnr, "prettierd"), "injected" }
            end,
        },
    },
}
