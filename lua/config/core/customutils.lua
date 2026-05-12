local function my_custom_utils()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  -- Define your commands here
  local utils = {
    {
      title = 'Wrap lines: ("text"),',
      -- 1. Remove carriage returns (e flag)
      -- 2. Capture line (.*) and wrap in ("\1"),
      cmd = [[:%s/\r//ge | %s/^\(.*\)$/("\1"),/]],
    },
  }

  pickers
    .new({}, {
      prompt_title = "Custom Utilities",
      finder = finders.new_table({
        results = utils,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.title,
            ordinal = entry.title,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          vim.cmd(selection.value.cmd)
        end)
        return true
      end,
    })
    :find()
end

-- Create a user command so you can just type :Utils
vim.api.nvim_create_user_command("Utils", my_custom_utils, {})

-- Optional: Map it to a single key that's easy to remember
-- vim.keymap.set("n", "<C-u>", my_custom_utils, { desc = "Open custom utilities menu" })
