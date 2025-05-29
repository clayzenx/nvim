return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = LazyVim.config.icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = auto,
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" } } },
          lualine_b = { "filename", "branch" },
          lualine_c = {
            "%=", --[[ add your center components here in place of this comment ]]
            {
              "harpoon2",
              icon = "",
              indicators = { "•", "•", "•", "•", "•" },
              active_indicators = { "•", "•", "•", "•", "•" },
              color_active = { fg = "#688686" },
              _separator = "",
              no_harpoon = "Harpoon not loaded",
            },
          },
          lualine_x = {},
          lualine_y = { "filetype", "progress" },
          lualine_z = {
            { "location", separator = { right = "" }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        tabline = {},
        extensions = {},
      }

      return opts
    end,
  },
}
