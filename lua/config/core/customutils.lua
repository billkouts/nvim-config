local function my_custom_utils()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  -- Define your commands here
  local utils = {
    {
      title = "Trim carriage returns (^M)",
      cmd = [[:%s/\r//ge]],
    },
    {
      title = 'Wrap lines: ("text"),',
      cmd = [[:%s/\r//ge | %s/^\(.*\)$/("\1"),/]],
    },
    {
      title = 'Wrap lines: "text",',
      cmd = [[:%s/^\(.*\)$/"\1",/]],
    },
    {
      title = "Join lines with comma",
      cmd = [[:%s/\n/,/g | %s/,$//]],
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
          vim.cmd("nohlsearch")
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
