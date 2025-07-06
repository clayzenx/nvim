return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        progress = {
          enabled = true,
        },
        hover = {
          enabled = true, -- Показывать LSP-доку через Noice (Shift-K)
          silent = false,
          view = nil, -- Можно "mini", "popup", nil
          opts = {
            win_options = {
              wrap = true,
              linebreak = true,
              winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            },
            max_width = 20, -- Максимальная ширина окна
            border = "single", -- Бордер вокруг окна
          },
        },
        signature = {
          enabled = true, -- Включает отображение сигнатур при вводе
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          opts = { focus = true, replace = true },
          view = "mini",
        },
      },
      views = {
        -- 👇 ВАЖНО: вот это для диагностики
        mini = {
          timeout = 1000, -- исчезает через 3 сек
          border = {
            style = "single",
          },
          position = {
            row = -2,
            col = -2,
          },
        },

        -- 👇 кастом для диагностического float-окна
        diagnostic = {
          size = {
            max_width = 80,
            max_height = 15,
          },
          border = {
            style = "rounded",
          },
          win_options = {
            wrap = true,
            linebreak = true,
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
          },
        },
        hover = {
          win_options = {
            wrap = true,
            linebreak = true,
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
          },
          border = {
            style = "single",
            padding = { 0, 1 },
          },
          position = {
            row = 1,
            col = 1,
          },
          size = {
            max_width = 60,
            max_height = 20,
          },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  -- stylua: ignore
  keys = {
    { "<leader>sn", "", desc = "+noice"},
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
  },
    config = function(_, opts)
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == "lazy" then
        vim.cmd([[messages clear]])
      end
      require("noice").setup(opts)
    end,
  },
}
