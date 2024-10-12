vim.g.mapleader = " "
vim.keymap.set("n", "<leader><Esc>", "<cmd>nohlsearch<cr>")

vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Go to window above" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Go to window below" })
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Go to window left" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Go to window right" })

vim.keymap.set("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>o", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>q", "<cmd>close<CR>", { desc = "Close current split" })

vim.keymap.set("n", "<leader>wk", ":resize +2<CR>", { desc = "Increase height" })
vim.keymap.set("n", "<leader>wj", ":resize -2<CR>", { desc = "Decrease height" })
vim.keymap.set("n", "<leader>wl", ":vertical resize +2<CR>", { desc = "Increase width" })
vim.keymap.set("n", "<leader>wh", ":vertical resize -2<CR>", { desc = "Decrease width" })
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>wfh", "<C-w>_<CR>", { desc = "Increase window to max height" })
vim.keymap.set("n", "<leader>wfw", "<C-w>|<CR>", { desc = "Increase window to max width" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 400 })
  end,
})

-- copy to clipboard
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })

-- paste from clipboard
vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste from system clipboard" })

-- select all text in buffer
vim.keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<left>", "<cmd>echo 'Use h to move!!'<CR>")
vim.keymap.set("n", "<right>", "<cmd>echo 'Use l to move!!'<CR>")
vim.keymap.set("n", "<up>", "<cmd>echo 'Use k to move!!'<CR>")
vim.keymap.set("n", "<down>", "<cmd>echo 'Use j to move!!'<CR>")
