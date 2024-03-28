return {
  { "williamboman/mason.nvim", opts = { PATH = "append" } },
  { "rvmelkonian/move.vim", ft = "move" },
  { "move-hub/tree-sitter-move", ft = "move" },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "cssls",
        "gopls",
        "html",
        "marksman",
        "neocmake",
        "jsonls",
        "lua_ls",
        "taplo",
        "tsserver",
        "yamlls",
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = {
        "shellcheck",
        "stylua",
        "prettierd",
        "shfmt",
        "shellcheck",
      },
      handlers = {
        taplo = function() end, -- disable taplo in null-ls, it's taken care of by lspconfig
        rome = function() end, -- disable rome in null-ls, it's taken care of by lspconfig
        -- prettierd = function()
        --   local null_ls = require "null-ls"
        --   null_ls.register(null_ls.builtins.formatting.prettierd.with {
        --     disabled_filetypes = {
        --       "javascript",
        --       "javascriptreact",
        --       "json",
        --       "typescript",
        --       "typescript.tsx",
        --       "typescriptreact",
        --     },
        --   })
        -- end,
      },
    },
  },
  {
    "towolf/vim-helm",
    ft = "helm",
  },
}
