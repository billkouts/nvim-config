return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
  opts = function()
    local cat_cmd = "cat | lolcat -F 0.2"
    if os.getenv("NO_LOLCAT") == "1" then
      cat_cmd = nil
    end
    local logo = [[
                   ██████╗ ███████╗██████╗  ██████╗ ██████╗....................
                   ██╔══██╗██╔════╝██╔══██╗██╔═══██╗██╔══██╗...................
                   ██████╔╝█████╗  ██████╔╝██║   ██║██████╔╝...................
                   ██╔══██╗██╔══╝  ██╔══██╗██║   ██║██╔═══╝....................
                   ██████╔╝███████╗██████╔╝╚██████╔╝██║........................
                   ╚═════╝ ╚══════╝╚═════╝  ╚═════╝ ╚═╝........................
                ██████╗ ██╗ ██████╗ ██╗████████╗ █████╗ ██╗....................
                ██╔══██╗██║██╔════╝ ██║╚══██╔══╝██╔══██╗██║....................
                ██║  ██║██║██║  ███╗██║   ██║   ███████║██║....................
                ██║  ██║██║██║   ██║██║   ██║   ██╔══██║██║....................
                ██████╔╝██║╚██████╔╝██║   ██║   ██║  ██║███████╗...............
                ╚═════╝ ╚═╝ ╚═════╝ ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝...............
   ███████╗ ██████╗ ██╗     ██╗   ██╗████████╗██╗ ██████╗ ███╗   ██╗███████╗...
   ██╔════╝██╔═══██╗██║     ██║   ██║╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝...
   ███████╗██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██╔██╗ ██║███████╗...
   ╚════██║██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║...
   ███████║╚██████╔╝███████╗╚██████╔╝   ██║   ██║╚██████╔╝██║ ╚████║███████║...
   ╚══════╝ ╚═════╝ ╚══════╝ ╚═════╝    ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝...
      ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        statusline = false,
      },
      preview = {
        -- this is used when cat_cmd is available
        command = cat_cmd,
        file_path = vim.fn.stdpath("config") .. "/lua/config/lazy/plugins/startup-screen-logo.txt",
        file_height = 18,
        file_width = 80,
      },
      config = {
        header = vim.split(logo, "\n"), -- if cat command is not available, then we fall back to the header
        -- stylua: ignore
        center = {
          { action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
          { action = "lua require('telescope.builtin').find_files()", desc = " Find File", icon = " ", key = "f" },
          { action = "lua require('telescope.builtin').oldfiles()", desc = " Recent Files", icon = " ", key = "r" },
          { action = "lua require('telescope.builtin').live_grep()", desc = " Find Text", icon = " ", key = "g" },
          { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
          { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit", icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- open dashboard after closing lazy
    if vim.o.filetype == "lazy" then
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
          end)
        end,
      })
    end

    return opts
  end,
}
