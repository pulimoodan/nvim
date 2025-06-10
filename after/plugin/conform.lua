require("conform").setup({
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "autopep8", "isort" },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        html = { "htmlbeautifier" },
    },
    formatters = {
        prettier = {
            prepend_args = { -- Add this line to properly pass args to prettier
                "--arrow-parens=always",
                "--bracket-same-line=false",
                "--bracket-spacing=true",
                "--embedded-language-formatting=auto",
                "--end-of-line=lf",
                "--html-whitespace-sensitivity=css",
                "--insert-pragma=false",
                "--print-width=80",
                "--prose-wrap=preserve",
                "--quote-props=as-needed",
                "--require-pragma=false",
                "--semi=true",
                "--single-quote=false",
                "--tab-width=2",
                "--trailing-comma=es5",
                "--use-tabs=false",
            }
        },
        autopep8 = {
            prepend_args = {
                { "--indent-size=2", "--ignore=E121", "--ignore=E305", "--ignore=E302" },
            },
        },
    },
})
