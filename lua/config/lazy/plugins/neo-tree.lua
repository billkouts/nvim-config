return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- TODO: image previewing doesn't work
  },
  config = function()
    vim.keymap.set(
      "n",
      "<leader>e",
      ":Neotree float focus reveal buffers<CR>",
      { desc = "Show file explorer float (buffers)" }
    )
    vim.keymap.set("n", "<leader>E", ":Neotree float reveal<CR>", { desc = "Show file explorer float" })
    vim.keymap.set("n", "<leader><C-e>", ":Neotree filesystem reveal right<CR>", { desc = "Show file explorer" })
    vim.keymap.set("n", "<leader>EI", ":Neotree position=current<CR>", { desc = "Show file explorer full" })
  end,
}
