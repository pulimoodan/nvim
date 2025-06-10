require("gitsigns").setup()
vim.keymap.set("n", "<leader>gs", ":Gitsigns preview_hunk_inline<cr>", {})
