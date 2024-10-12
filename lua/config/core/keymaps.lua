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

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down, keep cursor at the center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll down, keep cursor at the center" })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
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
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode from the built-in terminal" })

vim.keymap.set("n", "<left>", "<cmd>echo '😠😠😠😠😠😠😠😠😠'<CR>", { desc = "NO ARROW KEYS PLEASE" })
vim.keymap.set(
  "n",
  "<right>",
  "<cmd>echo '😠😠😠😠😠😠😠😠😠'<CR>",
  { desc = "NO ARROW KEYS PLEASE" }
)
vim.keymap.set("n", "<up>", "<cmd>echo '😠😠😠😠😠😠😠😠😠'<CR>", { desc = "NO ARROW KEYS PLEASE" })
vim.keymap.set("n", "<down>", "<cmd>echo '😠😠😠😠😠😠😠😠😠'<CR>", { desc = "NO ARROW KEYS PLEASE" })

-- Copy relative file path to clipboard
vim.keymap.set("n", "<leader>cf", function()
  local file_path = vim.fn.expand("%")
  vim.fn.setreg('"', file_path)
  vim.notify("Copied relative path to internal clipboard: " .. file_path, vim.log.levels.INFO, { title = "Clipboard" })
end, { desc = "Copy Relative Path to internal clipboard" })

vim.keymap.set("n", "<leader>cF", function()
  local file_path = vim.fn.expand("%")
  vim.fn.setreg("+", file_path)
  vim.notify("Copied relative path to system clipboard: " .. file_path, vim.log.levels.INFO, { title = "Clipboard" })
end, { desc = "Copy Relative Path to system clipboard" })

-- Move down and add new empty line
vim.keymap.set("n", "<C-j>", "o<Esc>", { desc = "Add new empty line below" })

-- Move up and add new empty line
vim.keymap.set("n", "<C-k>", "O<Esc>", { desc = "Add new empty line above" })
