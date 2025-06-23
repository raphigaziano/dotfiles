vim.g.mapleader = " "
vim.g.maplocaleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Use j+k to escape insert mode
vim.keymap.set('i', "jk", "<Esc>")

-- Clear search highlight  on pressing <Esc> in normal mode
vim.keymap.set('n', "<Esc>", "<cmd>nohlsearch<CR>")

-- Easier indenting in visual mode (keep block selected)
vim.keymap.set('v', "<", "<gv")
vim.keymap.set('v', ">", ">gv")

-- Move highlighted block up & down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- Delete to system clipboard
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Quickfix navigation
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Move current line up and down with Alt-[jk]
vim.keymap.set("n", "<M-j>", "<cmd>move+1<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>move-2<CR>")

-- Replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Toggle between current & last buffer
vim.keymap.set('n', "<leader>t", ":b#<cr>")

-- Uppercase previous word in insert mode
vim.keymap.set('i', "<C-u>", "<esc>mzgUiw`za")

-- Bind Ctrl+movement to move between windows
vim.keymap.set('n', "<C-j>", "<C-w>j")
vim.keymap.set('n', "<C-k>", "<C-w>k")
vim.keymap.set('n', "<C-h>", "<C-w>h")
vim.keymap.set('n', "<C-l>", "<C-w>l")

-- Source current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
