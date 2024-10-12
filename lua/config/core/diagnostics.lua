local border_style = "double"

vim.diagnostic.config({
  virtual_text = true,
  float = {
    focusable = false,
    style = "minimal",
    border = border_style,
    source = true,
  },
})

local function open_float()
  local opts = { focusable = false, border = border_style }
  vim.diagnostic.open_float(nil, opts)
end

local map = vim.keymap.set

map("n", "<leader>do", open_float, { desc = "Show diagnostic float" })

map("n", "<leader>dj", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

map("n", "<leader>dk", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })

map("n", "<leader>da", function()
  local wins = vim.fn.getwininfo()
  local loclist_open = false
  for _, w in pairs(wins) do
    if w.loclist == 1 then
      loclist_open = true
    end
  end

  if loclist_open then
    vim.cmd.lclose()
  else
    vim.diagnostic.setloclist({ open = true })
  end
end, { desc = "Toggle loclist" })

map("n", "<leader>dd", function()
  local config = vim.diagnostic.config()
  local enabled = false
  if config and (config.virtual_text == true or type(config.virtual_text) == "table") then
    enabled = true
  end

  if enabled then
    vim.diagnostic.config({ virtual_text = false, signs = false, underline = false })
    print("Diagnostics: Hidden")
  else
    vim.diagnostic.config({ virtual_text = true, signs = true, underline = true })
    print("Diagnostics: Shown")
  end
end, { desc = "Toggle diagnostics" })
