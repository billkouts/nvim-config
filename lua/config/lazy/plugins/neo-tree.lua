return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set(
      "n",
      "<leader>e",
      ":Neotree float focus reveal buffers<CR>",
      { desc = "Show file explorer float (buffers)" }
    )
    vim.keymap.set("n", "<leader>ee", ":Neotree float reveal<CR>", { desc = "Show file explorer float" })
    vim.keymap.set("n", "<leader>el", ":Neotree filesystem reveal right<CR>", { desc = "Show file explorer (left)" })
    vim.keymap.set("n", "<leader>eh", ":Neotree filesystem reveal left<CR>", { desc = "Show file explorer (left)" })
    vim.keymap.set("n", "<leader>ei", ":Neotree position=current<CR>", { desc = "Show file explorer in place" })
  end,
}
