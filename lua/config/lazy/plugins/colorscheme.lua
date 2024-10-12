-- You can easily change to a different colorscheme.
-- Change the name of the colorscheme plugin below, and then
-- change the command in the config function to whatever the name of that colorscheme is.
--
-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

return {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme("tokyonight-night")

      -- You can configure highlights by doing something like:
      vim.cmd.hi("Comment gui=none")
    end,
    opts = {
      dim_inactive = true,
    },
  },
}

-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   priority = 1000,
--   lazy = false,
--   config = function()
--     require("catppuccin").setup({
--       flavour = "mocha", -- latte, frappe, macchiato, mocha
--     })
--     vim.cmd.colorscheme("catppuccin")
--   end,
-- }

-- return {
--   {
--     "scottmckendry/cyberdream.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       require("cyberdream").setup({
--         transparent = true,
--         extensions = {
--           telescope = true,
--         },
--       })
--       vim.cmd.colorscheme("cyberdream")
--     end,
--   },
-- }
--

-- other themes to try
-- https://github.com/cpea2506/one_monokai.nvim
-- https://github.com/svrana/neosolarized.nvim
-- https://github.com/b0o/lavi.nvim
-- https://github.com/Tsuzat/NeoSolarized.nvim
-- https://github.com/shaunsingh/moonlight.nvim
-- https://github.com/shaunsingh/nord.nvim
-- https://github.com/gbprod/nord.nvim
-- https://github.com/rmehri01/onenord.nvim
-- https://github.com/bluz71/vim-moonfly-colors
-- https://github.com/bluz71/vim-nightfly-colors
-- https://github.com/0xstepit/flow.nvim
-- https://github.com/dracula/vim
-- https://github.com/uloco/bluloco.nvim
-- https://github.com/xero/miasma.nvim
-- https://github.com/zootedb0t/citruszest.nvim
-- https://github.com/sho-87/kanagawa-paper.nvim
-- https://github.com/embark-theme/vim
-- https://github.com/rafamadriz/neon
-- https://github.com/samharju/synthweave.nvim
