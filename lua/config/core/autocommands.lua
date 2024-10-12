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
  {
    pattern = { "elixir" },
    char = "|",
    result = "|>",
    timeout = 500,
  },
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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  end,
})
