-- return {
--   -- TODO: set up debugging properly
--   -- https://www.lazyvim.org/extras/lang/ruby for a list of plugins I can use
--   -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ruby or this might be useful for how to set up debugging
--   -- https://www.lazyvim.org/keymaps#nvim-dap
-- }

return {
  -- Core DAP plugin
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui", -- For a UI for DAP
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python", -- For Python debugging
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup DAP UI
      dapui.setup()

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      vim.keymap.set("n", "<F5>", ":lua require('dap').continue()<CR>", { desc = "Start/Continue Debugging" })
      vim.keymap.set("n", "<F10>", ":lua require('dap').step_over()<CR>", { desc = "Step Over" })
      vim.keymap.set("n", "<F11>", ":lua require('dap').step_into()<CR>", { desc = "Step Into" })
      vim.keymap.set("n", "<F12>", ":lua require('dap').step_out()<CR>", { desc = "Step Out" })
      vim.keymap.set("n", "<Leader>b", ":lua require('dap').toggle_breakpoint()<CR>", { desc = "Toggle Breakpoint" })
      vim.keymap.set(
        "n",
        "<Leader>B",
        ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
        { desc = "Set Conditional Breakpoint" }
      )
      vim.keymap.set("n", "<Leader>dr", ":lua require('dap').repl.open()<CR>", { desc = "Open REPL" })
    end,
  },

  -- Python-specific setup
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup("~/.venv/debugpy/bin/python") -- Adjust to your Python path
    end,
  },
}
