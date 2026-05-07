return {
  {
    "mistweaverco/kulala.nvim",
    keys = {
      {
        "<leader>rr",
        function()
          require("kulala").run()
        end,
        desc = "Kulala: Run HTTP request",
      },
      {
        "<leader>ro",
        function()
          require("kulala").open()
        end,
        desc = "Kulala: Open UI",
      },
    },
    opts = {},
    config = function(_, opts)
      require("kulala").setup(opts)

      vim.filetype.add({
        extension = { ["http"] = "http" },
      })
    end,
  },
}
