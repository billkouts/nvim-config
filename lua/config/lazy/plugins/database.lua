local function get_db_url(pass_path)
  return vim.fn.trim(vim.fn.system("pass " .. pass_path))
end

-- Define your database connections here.
-- For production/sensitive credentials, use pass (GPG-encrypted).
-- For local/docker connections, plain URLs are fine.
--
-- Plain URL format:
--   mysql://user:password@host:port/dbname
--   postgresql://user:password@host:port/dbname
--
-- Examples:
--   Plain:  { name = "local-app1",   url = "mysql://root:root@localhost:3306/app1" },
--   Docker: { name = "docker-app1",  url = "mysql://user:pass@localhost:3307/app1" },
--   Pass:   { name = "app1-prod-ro", url = get_db_url("apps/app1/production/readonly") },

vim.g.dbs = {
  -- local connections (plain URL)
  -- { name = "local-app1",   url = "mysql://root:root@localhost:3306/app1" },

  -- docker connections (plain URL)
  { name = "guru-docker-local", url = "mysql://root:root@localhost:3306/local_prod_db_guru" },

  -- production connections (via pass)
  { name = "apps/guru/production/readonly", url = get_db_url("apps/guru/production/readonly") },
  { name = "apps/hub/production/readonly", url = get_db_url("apps/hub/production/readonly") },
}

local export_job_id = nil

local function parse_mysql_url(url)
  local after_scheme = url:match("^mysql://(.+)$")
  if not after_scheme then
    return nil
  end

  local at_pos = after_scheme:find("@[^@]*$")
  if not at_pos then
    return nil
  end

  local user_pass = after_scheme:sub(1, at_pos - 1)
  local host_rest = after_scheme:sub(at_pos + 1)
  local user, password = user_pass:match("^([^:]+):(.+)$")
  local host, port, dbname = host_rest:match("^([^:]+):(%d+)/(.+)$")

  if not host then
    host, dbname = host_rest:match("^([^/]+)/(.+)$")
    port = "3306"
  end

  if not user or not host or not dbname then
    return nil
  end
  return user, password, host, port, dbname
end

local function resolve_filepath(input)
  if input:sub(1, 1) == "/" or input:sub(1, 1) == "~" then
    return vim.fn.expand(input)
  end
  return vim.fn.getcwd() .. "/" .. input
end

local function export_query_to_csv()
  local db_url = vim.b.db or vim.g.db
  if not db_url or db_url == "" then
    vim.notify(
      "No active DB connection. Open a query buffer in DBUI first.",
      vim.log.levels.ERROR,
      { title = "DB Export" }
    )
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local filtered = {}
  for _, line in ipairs(lines) do
    if not line:match("^%s*%-%-") then
      table.insert(filtered, line)
    end
  end
  local query = vim.fn.trim(table.concat(filtered, "\n"))
  if query == "" then
    vim.notify("Query buffer is empty.", vim.log.levels.WARN, { title = "DB Export" })
    return
  end

  local user, password, host, port, dbname = parse_mysql_url(db_url)
  if not user then
    vim.notify(
      "Could not parse connection URL. Only MySQL/MariaDB supported.",
      vim.log.levels.ERROR,
      { title = "DB Export" }
    )
    return
  end

  local default_path = vim.fn.getcwd() .. "/export.csv"

  vim.ui.input({ prompt = "Save CSV as: ", default = default_path }, function(input)
    if not input or input == "" then
      return
    end
    local filepath = resolve_filepath(input)

    local start_time = vim.uv.hrtime()
    local timer = vim.uv.new_timer()

    timer:start(
      0,
      1000,
      vim.schedule_wrap(function()
        local elapsed = math.floor((vim.uv.hrtime() - start_time) / 1e9)
        vim.api.nvim_echo(
          { { string.format("  Exporting... %ds elapsed  |  <leader>sqlX to cancel", elapsed), "WarningMsg" } },
          false,
          {}
        )
      end)
    )

    export_job_id = vim.system(
      { "mysql", "-u", user, "-p" .. password, "-h", host, "-P", port, "--batch", dbname, "-e", query },
      { text = true },
      function(result)
        export_job_id = nil
        timer:stop()
        timer:close()

        vim.schedule(function()
          vim.api.nvim_echo({ { "" } }, false, {})

          if result.code ~= 0 then
            vim.notify("Export failed:\n" .. (result.stderr or ""), vim.log.levels.ERROR, { title = "DB Export" })
            return
          end

          local csv_lines = {}
          for line in (result.stdout or ""):gmatch("[^\n]+") do
            local fields = vim.split(line, "\t", { plain = true })
            local quoted = {}
            for _, field in ipairs(fields) do
              if field:find('[,"\n]') then
                field = '"' .. field:gsub('"', '""') .. '"'
              end
              table.insert(quoted, field)
            end
            table.insert(csv_lines, table.concat(quoted, ","))
          end

          local file = io.open(filepath, "w")
          if file then
            file:write(table.concat(csv_lines, "\n"))
            file:close()
            vim.notify(
              string.format("Exported %d rows to %s", #csv_lines - 1, filepath),
              vim.log.levels.INFO,
              { title = "DB Export" }
            )
          else
            vim.notify("Could not write to " .. filepath, vim.log.levels.ERROR, { title = "DB Export" })
          end
        end)
      end
    )
  end)
end

local function cancel_export()
  if export_job_id then
    export_job_id:kill(9)
    export_job_id = nil
    vim.notify("Export cancelled.", vim.log.levels.WARN, { title = "DB Export" })
  else
    vim.notify("No export in progress.", vim.log.levels.INFO, { title = "DB Export" })
  end
end

return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_execute_on_save = 0
    end,
    keys = {
      { "<leader>sqlt", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
      { "<leader>sqla", "<cmd>DBUIAddConnection<CR>", desc = "Add DB connection" },
      { "<leader>sqlf", "<cmd>DBUIFindBuffer<CR>", desc = "Find DB buffer" },
      { "<leader>sqlx", export_query_to_csv, desc = "Export query to CSV" },
      { "<leader>sqlX", cancel_export, desc = "Cancel CSV export" },
    },
    config = function() end,
  },
}
