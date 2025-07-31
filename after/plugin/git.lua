local gs = require("gitsigns")
gs.setup()

vim.keymap.set("n", "<leader>xp", ":Gitsigns preview_hunk_inline<cr>", {})
vim.keymap.set("n", "<leader>xb", ":Gitsigns toggle_current_line_blame<cr>", {})
vim.keymap.set("n", "<leader>xs", ":Gitsigns stage_hunk<cr>", {})
vim.keymap.set("n", "<leader>xu", ":Gitsigns undo_stage_hunk<cr>", {})
vim.keymap.set("n", "<leader>xn", ":Gitsigns next_hunk<cr>", {})
vim.keymap.set("n", "<leader>xN", ":Gitsigns prev_hunk<cr>", {})
vim.keymap.set("n", "<leader>xr", ":Gitsigns reset_hunk<cr>", {})

-- Get diff in vertical split and clean up after closing the diff window
vim.keymap.set("n", "<leader>xd", function()
    local original_buf = vim.api.nvim_get_current_buf()
    local original_name = vim.api.nvim_buf_get_name(original_buf)

    vim.cmd("only")
    gs.diffthis()

    vim.api.nvim_create_autocmd("WinClosed", {
        callback = function()
            vim.schedule(function()
                local curr_name = vim.api.nvim_buf_get_name(0)
                local modifiable = vim.bo.modifiable

                if curr_name:find("%.git") or not modifiable then
                    vim.cmd("edit " .. vim.fn.fnameescape(original_name))
                end

                vim.cmd("diffoff!")
            end)
        end,
        once = true,
    })
end, {})
