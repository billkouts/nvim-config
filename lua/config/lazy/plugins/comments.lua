return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup()
      -- Add the keymap here
      vim.keymap.set("n", "<leader>tt", "<cmd>TodoTelescope<cr>", { desc = "Telescope search for todos" })
    end,
    opts = {},
  },
}
