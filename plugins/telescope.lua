return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-hop.nvim",
    "nvim-telescope/telescope-bibtex.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "ahmedkhalf/project.nvim", -- defined in  ./editor.lua
    -- HACK: new update
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = function(_, opts)
    local telescope = require "telescope"
    local actions = require "telescope.actions"
    local fb_actions = require("telescope").extensions.file_browser.actions
    local hop = telescope.extensions.hop
    return require("astronvim.utils").extend_tbl(opts, {
      defaults = {
        selection_caret = "  ",
        layout_config = {
          width = 0.90,
          height = 0.85,
          preview_cutoff = 120,
          horizontal = {
            preview_width = 0.6,
          },
          vertical = {
            width = 0.9,
            height = 0.95,
            preview_height = 0.5,
          },
          flex = {
            horizontal = {
              preview_width = 0.9,
            },
          },
        },
        mappings = {
          i = {
            ["<C-h>"] = hop.hop,
            ["<C-space>"] = function(prompt_bufnr)
              hop._hop_loop(
                prompt_bufnr,
                { callback = actions.toggle_selection, loop_callback = actions.send_selected_to_qflist }
              )
            end,
          },
        },
      },
      extensions = {
        bibtex = { context = true, context_fallback = false },
        file_browser = {
          mappings = {
            i = {
              ["<C-z>"] = fb_actions.toggle_hidden,
            },
            n = {
              z = fb_actions.toggle_hidden,
            },
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          find_command = function(cfg)
            local find_command = { "rg", "--files", "--color", "never" }
            if not cfg.no_ignore then vim.list_extend(find_command, { "--glob", "!**/.git/**" }) end
            return find_command
          end,
        },
        buffers = {
          path_display = { "smart" },
          mappings = {
            i = { ["<c-d>"] = actions.delete_buffer },
            n = { ["d"] = actions.delete_buffer },
          },
        },
      },
    })
  end,
  config = function(...)
    require "plugins.configs.telescope"(...)
    local telescope = require "telescope"
    telescope.load_extension "bibtex"
    telescope.load_extension "file_browser"
    telescope.load_extension "projects"
  end,
}
