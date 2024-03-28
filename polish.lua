return function()
  local function yaml_ft(path, bufnr)
    -- get content of buffer as string
    if type(content) == "table" then content = table.concat(content, "\n") end

    -- check if file is in roles, tasks, or handlers folder
    local path_regex = vim.regex "(tasks\\|roles\\|handlers)/"
    if path ~= nil and path_regex and path_regex:match_str(path) then return "yaml.ansible" end
    -- check for known ansible playbook text and if found, return yaml.ansible
    local regex = vim.regex "hosts:\\|tasks:"
    if content ~= nil and regex and regex:match_str(content) then return "yaml.ansible" end

    -- return yaml if nothing else
    return "yaml"
  end

  vim.filetype.add {
    extension = {
      qmd = "markdown",
      yml = yaml_ft,
      yaml = yaml_ft,
      -- Move language
      move = "move",
    },
    pattern = {
      ["/tmp/neomutt.*"] = "markdown",
      -- helm
      [".*/templates/.*.yaml"] = "helm",
      [".*/templates/.*.yml"] = "helm",
    },
  }

  require "user.autocmds"
end
