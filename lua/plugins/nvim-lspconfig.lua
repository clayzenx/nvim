-- Override nvim-lspconfig to register and start a custom Tact language server
return {
  {
    "neovim/nvim-lspconfig",
    -- Merge our custom 'tact' server config into LazyVim's LSP setup
    opts = function(_, opts)
      local configs = require("lspconfig.configs")
      local util = require("lspconfig.util")
      -- Define the 'tact' server if not already available
      if not configs.tact then
        configs.tact = {
          default_config = {
            cmd = { "node", "/Users/devymurr/.lsp/tact-language-server/dist/server.js", "--stdio" },
            filetypes = { "tact" },
            root_dir = util.root_pattern("package.json", ".git"),
          },
          docs = {
            description = [[
              Tact Language Server
              https://github.com/tact-lang/tact-language-server
            ]],
            default_config = {
              root_dir = [[ root_pattern("package.json", ".git") ]],
            },
          },
        }
      end
      -- Ensure the 'tact' server is started
      opts.servers = opts.servers or {}
      opts.servers.tact = {}
      return opts
    end,
  },
}
