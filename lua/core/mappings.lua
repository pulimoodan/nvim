vim.g.mapleader = " "                    -- easy to reach leader key
vim.opt.cursorline = true                -- highlight current line

vim.keymap.set("n", "x", '"_x')          -- prevent deleting single char to clipboard

vim.keymap.set("n", "<C-a>", "gg<S-v>G") -- select all

-- file explorer
vim.api.nvim_create_user_command('NetrwToggle', function()
    if vim.bo.filetype == "netrw" then
        vim.cmd('Rex')
    else
        vim.cmd('Ex')
    end
end, {})
vim.keymap.set("n", "<leader>e", ":NetrwToggle<cr>")    -- open file explorer
vim.keymap.set("n", "<leader>s", "<cmd>w<cr>")          -- save file
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>")          -- quit
vim.keymap.set("n", "<leader>Q", "<cmd>qa<cr>")         -- quit all

vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>")     -- next buffer
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>") -- prev buffer
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>")        -- prev buffer

-- window management
vim.keymap.set("n", "<leader>wq", "<C-w>q") -- quit
vim.keymap.set("n", "<leader>wd", "<C-w>s") -- split down
vim.keymap.set("n", "<leader>wr", "<C-w>v") -- split right
vim.keymap.set("n", "<leader>wl", "<C-w>l") -- move to right
vim.keymap.set("n", "<leader>wh", "<C-w>h") -- move to left
vim.keymap.set("n", "<leader>wk", "<C-w>k") -- move to top
vim.keymap.set("n", "<leader>wj", "<C-w>j") -- move to bottom
vim.keymap.set("n", "<leader>wm", "<C-w>o") -- maximize

vim.keymap.set("t", "kj", "<C-\\><C-n>")    -- exit from terminal
vim.keymap.set("i", "kj", "<esc>")          -- exit from insert

-- move line in highlight mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- stay in center on scroll or search
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")         -- preserve the pasting buffer
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y") -- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>Y", "\"+Y") -- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d") -- prevent copy while deleting

-- prevent exiting from visual mode
-- after indenting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
