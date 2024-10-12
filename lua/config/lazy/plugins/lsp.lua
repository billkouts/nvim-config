-- minimal configuration
-- return {
--   "mason-org/mason-lspconfig.nvim",
--   opts = {},
--   dependencies = {
--     { "mason-org/mason.nvim", opts = {} },
--     "neovim/nvim-lspconfig",
--   },
-- }

-- --
return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    { "williamboman/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
    "folke/lazydev.nvim",
  },
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "intelephense",
        "ts_ls",
        "tailwindcss",
        "astro",
        "laravel_ls",
        "stylua",
        "html",
        "astro",
        "pyright",
        "ruff",
      },

      handlers = {
        -- 1. The Default Handler (for everything NOT Intelephense)
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,

        -- 2. The Intelephense Handler (Specific for Laravel)
        ["intelephense"] = function()
          require("lspconfig").intelephense.setup({
            settings = {
              intelephense = {
                files = { maxSize = 5000000 },
                environment = {
                  includePaths = { "vendor/laravel/framework/src/Illuminate" },
                },
              },
            },
          })
        end,
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({})
        end,
      },
    })
  end,
}
