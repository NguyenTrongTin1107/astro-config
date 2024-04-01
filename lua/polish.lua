-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    qmd = "markdown",
    -- Move language
    move = "move",
  },
  filename = {
    -- ["Foofile"] = "fooscript",
  },
  pattern = {
    -- helm
    [".*/templates/.*.yaml"] = "helm",
    [".*/templates/.*.yml"] = "helm",
  },
}
