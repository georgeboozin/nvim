return {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {},
    config = function()
        require("tree-sitter-manager").setup({
            ensure_installed = {
                "lua",
                "vimdoc",
                "javascript",
                "typescript",
                "tsx",
                "bash",
                "c",
                "html",
                "luadoc",
                "markdown",
                "vim",
                "rust",
                "toml",
                "groovy",
            },
            auto_install = true,
        })
    end,
}
