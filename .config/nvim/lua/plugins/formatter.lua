return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                bash = { "beautysh" },
                javascript = { "prettierd", "prettier" },
                typescript = { "prettierd", "prettier" },
                javascriptreact = { "prettierd", "prettier" },
                typescriptreact = { "prettierd", "prettier" },
                svelte = { "prettierd", "prettier" },
                css = { "prettierd", "prettier" },
                html = { "prettierd", "prettier" },
                json = { "prettierd", "prettier" },
                yaml = { "prettierd", "prettier" },
                markdown = { "prettierd", "prettier" },
                graphql = { "prettierd", "prettier" },
                liquid = { "prettierd", "prettier" },
                lua = { "stylua" },
                python = { "isort", "black" }
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000
            }
        })

        vim.keymap.set({ "n", "v" }, "<leader>ff", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000
            })
        end, { desc = "Format file or selected range in visual mode." })
    end
}
