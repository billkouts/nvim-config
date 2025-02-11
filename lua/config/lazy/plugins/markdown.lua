return {
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   build = "cd app && npm install",
  --   init = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --   end,
  --   ft = { "markdown" },
  --   config = function()
  --     vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "[M]arkdown [P]review" })
  --   end,
  -- },
  -- {
  --   "MeanderingProgrammer/render-markdown.nvim",
  --   dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  --   ---@module 'render-markdown'
  --   ---@type render.md.UserConfig
  --   ft = { "markdown" },
  --   opts = {},
  --   config = function()
  --     vim.keymap.set("n", "<leader>mi", "<cmd>RenderMarkdown toggle<cr>", { desc = "[M]arkdown [P]review" })
  --   end,
  -- },
}

-- TODO: check to replace iamcco markdown preview with https://github.com/jannis-baum/vivify.vim, because
-- 1. plugin is not actively maintained
-- 2. github flavoured markdown (warning, tip, etc) do not show up properly

-- TODO: check the following plugins:
-- https://github.com/bullets-vim/bullets.vim
-- https://github.com/echasnovski/mini.ai
-- https://github.com/echasnovski/mini.surround
-- https://github.com/hedyhli/outline.nvim
-- https://github.com/lukas-reineke/headlines.nvim
-- https://github.com/nvim-pack/nvim-spectre
-- https://github.com/folke/trouble.nvim
