vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("v", "jj", "<Esc>")


-- cmake remaps
vim.keymap.set("n", "<leader>cg", ":CMakeGenerate<CR>")
vim.keymap.set("n", "<leader>cb", ":CMakeBuild<CR>")
vim.keymap.set("n", "<leader>cq", ":CMakeClose<CR>")

-- copy and paste remaps
vim.keymap.set("v", "<leader>yy", "\"+yy")
vim.keymap.set("n", "<leader>yy", "\"+yy")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>y", "\"+y")

vim.keymap.set("v", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>p", "\"+p")

vim.keymap.set("n", "<leader>k", "<C-u>")
vim.keymap.set("n", "<leader>j", "<C-d>")


vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>r', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>w', vim.diagnostic.goto_prev)
