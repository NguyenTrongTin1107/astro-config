return {
  -- add custom handler
  dartls = function(_, opts) require("flutter-tools").setup { lsp = opts } end,
  rust_analyzer = function(_, opts) require("rust-tools").setup { server = opts } end,
  tsserver = function(_, opts) require("typescript").setup { server = opts } end,
  movels = function(_, opts) require("move-tool").setup { lsp = opts } end,
}
