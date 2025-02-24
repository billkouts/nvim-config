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

-- Store the last time we typed a dash
local last_dash_time = 0

vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    vim.keymap.set("i", "-", function()
      local now = vim.loop.hrtime() / 1e6 -- milliseconds
      local diff = now - last_dash_time
      last_dash_time = now

      -- If the previous key was "-" within 500ms, replace with "->"
      if diff < 500 then
        -- delete the previous "-" and insert "->"
        return "<BS>->"
      else
        return "-"
      end
    end, { buffer = true, expr = true })
  end,
})
