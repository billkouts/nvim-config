return {
  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = { timeout_ms = 750, lsp_format = "fallback" },
      formatters_by_ft = {
        lua = { "stylua" },
        sql = { "sql_formatter_sql" },
        mysql = { "sql_formatter_mysql" },
        plsql = { "sql_formatter_plsql" },
        html = { "prettier" },
        css = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" }, -- For .jsx files
        typescriptreact = { "prettier" }, -- For .tsx files
        svg = { "xmlformatter" },
        json = { "prettier" },
        ["markdown"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        elixir = { "mix" },
        heex = { "mix" },
        php = { "pint" },
        blade = { "blade-formatter" },
      },
      formatters = {
        sql_formatter_sql = {
          command = "sql-formatter",
          args = { "--config", '{"language":"sql","keywordCase":"upper","functionCase":"upper"}' },
        },
        sql_formatter_sqlite = {
          command = "sql-formatter",
          args = { "--config", '{"language":"sqlite","keywordCase":"upper","functionCase":"upper"}' },
        },
        sql_formatter_mysql = {
          command = "sql-formatter",
          args = { "--config", '{"language":"mysql","keywordCase":"upper","functionCase":"upper"}' },
        },
        sql_formatter_postgresql = {
          command = "sql-formatter",
          args = { "--config", '{"language":"postgresql","keywordCase":"upper","functionCase":"upper"}' },
        },
        sql_formatter_plsql = {
          command = "sql-formatter",
          args = { "--config", '{"language":"plsql","keywordCase":"upper","functionCase":"upper"}' },
        },
        mix = {
          command = "mix",
          args = { "format", "--stdin-filename", "$FILENAME", "-" },
          stdin = true,
        },
      },
    },
  },
}
