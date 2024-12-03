-- Auto-open Neo-tree when starting nvim with a directory
-- it doesn't work great with the Dashboard plugin, seems better to have open the dashboard regardless
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     local args = vim.fn.argv()
--     if #args == 1 and vim.fn.isdirectory(args[1]) == 1 then
--       require("neo-tree").setup({})
--       vim.cmd("Neotree float focus reveal buffers")
--     end
--   end,
-- })

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local args = vim.fn.argv()
    if #args == 1 and vim.fn.isdirectory(args[1]) == 1 then
      vim.cmd("Dashboard")
    end
  end,
})
