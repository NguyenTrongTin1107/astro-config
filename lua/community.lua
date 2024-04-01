-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- Language
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.rust" },

  { import = "astrocommunity.colorscheme.catppuccin" },
}
