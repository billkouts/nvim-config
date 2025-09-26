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

local double_tap_mappings = {
  {
    pattern = { "php" },
    char = "-",
    result = "->",
    timeout = 500,
  },
  {
    pattern = { "php" },
    char = "=",
    result = "=>",
    timeout = 500,
  },
  -- you can add more here easily
  -- {
  --   pattern = { "php", "javascript" },
  --   char = ">",
  --   result = ">>",
  --   timeout = 300,
  -- },
}

for _, cfg in ipairs(double_tap_mappings) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = cfg.pattern,
    callback = function(args)
      local last_press = 0

      vim.keymap.set("i", cfg.char, function()
        local now = vim.loop.hrtime() / 1e6
        local diff = now - last_press
        last_press = now

        if diff < cfg.timeout then
          return "<BS>" .. cfg.result
        else
          return cfg.char
        end
      end, { buffer = args.buf, expr = true })
    end,
  })
end
