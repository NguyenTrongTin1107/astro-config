local utils = require "user.utils"
local astro_utils = require "astronvim.utils"
local mappings = {
  n = {
    -- disable default bindings
    ["<C-Down>"] = false,
    ["<C-Left>"] = false,
    ["<C-Right>"] = false,
    ["<C-Up>"] = false,
    ["<C-q>"] = false,
    ["<C-s>"] = false,
    ["q:"] = ":",
    -- better buffer navigation
    ["]b"] = false,
    ["[b"] = false,
    ["<S-l>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-h>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    -- better search
    n = { utils.better_search "n", desc = "Next search" },
    N = { utils.better_search "N", desc = "Previous search" },
    -- better increment/decrement
    ["-"] = { "<c-x>", desc = "Descrement number" },
    ["+"] = { "<c-a>", desc = "Increment number" },
    -- resize with arrows
    ["<Up>"] = { function() require("smart-splits").resize_up(2) end, desc = "Resize split up" },
    ["<Down>"] = { function() require("smart-splits").resize_down(2) end, desc = "Resize split down" },
    ["<Left>"] = { function() require("smart-splits").resize_left(2) end, desc = "Resize split left" },
    ["<Right>"] = { function() require("smart-splits").resize_right(2) end, desc = "Resize split right" },
    -- Easy-Align
    ga = { "<Plug>(EasyAlign)", desc = "Easy Align" },
    -- buffer switching
    ["<Tab>"] = {
      function()
        if #vim.t.bufs > 1 then
          require("telescope.builtin").buffers { sort_mru = true, ignore_current_buffer = true }
        else
          astro_utils.notify "No other buffers open"
        end
      end,
      desc = "Switch Buffers",
    },
    -- vim-sandwich
    ["s"] = "<Nop>",
    ["<leader>n"] = { "<cmd>enew<cr>", desc = "New File" },
    ["<leader>N"] = { "<cmd>tabnew<cr>", desc = "New Tab" },
    ["<leader><cr>"] = { '<esc>/<++><cr>"_c4l', desc = "Next Template" },
    ["<leader>."] = { "<cmd>cd %:p:h<cr>", desc = "Set CWD" },
    -- neogen
    ["<leader>a"] = { desc = "󰏫 Annotate" },
    ["<leader>a<cr>"] = { function() require("neogen").generate() end, desc = "Current" },
    ["<leader>ac"] = { function() require("neogen").generate { type = "class" } end, desc = "Class" },
    ["<leader>af"] = { function() require("neogen").generate { type = "func" } end, desc = "Function" },
    ["<leader>at"] = { function() require("neogen").generate { type = "type" } end, desc = "Type" },
    ["<leader>aF"] = { function() require("neogen").generate { type = "file" } end, desc = "File" },
    -- telescope plugin mappings
    ["<leader>fB"] = { "<cmd>Telescope bibtex<cr>", desc = "Find BibTeX" },
    ["<leader>fe"] = { "<cmd>Telescope file_browser<cr>", desc = "File explorer" },
    ["<leader>fp"] = { function() require("telescope").extensions.projects.projects {} end, desc = "Find projects" },
    ["<leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
    -- compiler
    ["<leader>m"] = { desc = "󱁤 Compiler" },
    ["<leader>mk"] = {
      function()
        vim.cmd "silent! write"
        local filename = vim.fn.expand "%:t"
        utils.async_run({ "compiler", vim.fn.expand "%:p" }, function() astro_utils.notify("Compiled " .. filename) end)
      end,
      desc = "Compile",
    },
    ["<leader>ma"] = {
      function()
        vim.notify "Autocompile Started"
        utils.async_run({ "autocomp", vim.fn.expand "%:p" }, function() astro_utils.notify "Autocompile stopped" end)
      end,
      desc = "Auto Compile",
    },
    ["<leader>mv"] = {
      function() vim.fn.jobstart { "opout", vim.fn.expand "%:p" } end,
      desc = "View Output",
    },
    ["<leader>mb"] = {
      function()
        local filename = vim.fn.expand "%:t"
        utils.async_run({
          "pandoc",
          vim.fn.expand "%",
          "--pdf-engine=xelatex",
          "--variable",
          "urlcolor=blue",
          "-t",
          "beamer",
          "-o",
          vim.fn.expand "%:r" .. ".pdf",
        }, function() astro_utils.notify("Compiled " .. filename) end)
      end,
      desc = "Compile Beamer",
    },
    ["<leader>mp"] = {
      function()
        local pdf_path = vim.fn.expand "%:r" .. ".pdf"
        if vim.fn.filereadable(pdf_path) == 1 then vim.fn.jobstart { "pdfpc", pdf_path } end
      end,
      desc = "Present Output",
    },
    ["<leader>ml"] = { function() utils.toggle_qf() end, desc = "Logs" },
    ["<leader>mt"] = { "<cmd>TexlabBuild<cr>", desc = "LaTeX" },
    ["<leader>mf"] = { "<cmd>TexlabForward<cr>", desc = "Forward Search" },
    ["<leader>z"] = { "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    ["<leader>s"] = { desc = "󰛔 Search/Replace" },
    ["<leader>ss"] = { function() require("spectre").open() end, desc = "Spectre" },
    ["<leader>sf"] = { function() require("spectre").open_file_search() end, desc = "Spectre (current file)" },
    ["<leader>sw"] = {
      function() require("spectre").open_visual { select_word = true } end,
      desc = "Spectre (current word)",
    },
    ["<leader>x"] = { desc = "󰒡 Trouble" },
    ["<leader>xx"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
    ["<leader>xX"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    ["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
    ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    ["<leader>xT"] = { "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" },
    ["<leader>;"] = { desc = "󰧑 AI Assistant" },
    ["<leader>;;"] = {
      function()
        vim.cmd.Codeium(vim.g.codeium_enabled == 0 and "Enable" or "Disable")
        astro_utils.notify("Codeium " .. (vim.g.codeium_enabled == 0 and "Disabled" or "Enabled"))
      end,
      desc = "Toggle Global",
    },
    ["<leader>;b"] = {
      function()
        vim.cmd.Codeium(vim.b.codeium_enabled == 0 and "EnableBuffer" or "DisableBuffer")
        astro_utils.notify("Codeium (buffer) " .. (vim.b.codeium_enabled == 0 and "Disabled" or "Enabled"))
      end,
      desc = "Toggle Buffer",
    },
    -- ChatGPT
    ["<leader>?"] = { desc = "Chat GPT" },
    ["<leader>??"] = { "<cmd>ChatGPT<cr>", desc = "Ask question" },
    ["<leader>?n"] = { "<cmd>ChatGPTActAs<cr>", desc = "New Model" },
    ["<leader>?g"] = { "<cmd>ChatGPTRun grammar_correction<cr>", desc = "Grammar Check" },
    ["<leader>?t"] = { "<cmd>ChatGPTRun translate<cr>", desc = "Translate" },
    ["<leader>?k"] = { "<cmd>ChatGPTRun keywords<cr>", desc = "Keywords" },
    ["<leader>?d"] = { "<cmd>ChatGPTRun docstring<cr>", desc = "Docstring" },
    ["<leader>?e"] = { "<cmd>ChatGPTRun add_tests<cr>", desc = "Add tests" },
    ["<leader>?o"] = { "<cmd>ChatGPTRun optimize_code<cr>", desc = "Optimize code" },
    ["<leader>?s"] = { "<cmd>ChatGPTRun summarize<cr>", desc = "Summarize" },
    ["<leader>?f"] = { "<cmd>ChatGPTRun fix_bugs<cr>", desc = "Fix bugs" },
    ["<leader>?E"] = { "<cmd>ChatGPTRun explain_code<cr>", desc = "Explain code" },
    ["<leader>?a"] = { "<cmd>ChatGPTRun code_readability_analysis<cr>", desc = "Readability analysis" },
  },
  v = {
    ["<leader>s"] = { function() require("spectre").open_visual() end, desc = "Spectre" },

    -- Chat GPT
    ["<leader>?"] = { desc = "Chat GPT" },
    ["<leader>?g"] = { "<cmd>ChatGPTRun grammar_correction<cr>", desc = "Grammar Check" },
    ["<leader>?t"] = { "<cmd>ChatGPTRun translate<cr>", desc = "Translate" },
    ["<leader>?k"] = { "<cmd>ChatGPTRun keywords<cr>", desc = "Keywords" },
    ["<leader>?d"] = { "<cmd>ChatGPTRun docstring<cr>", desc = "Docstring" },
    ["<leader>?e"] = { "<cmd>ChatGPTRun add_tests<cr>", desc = "Add tests" },
    ["<leader>?o"] = { "<cmd>ChatGPTRun optimize_code<cr>", desc = "Optimize code" },
    ["<leader>?s"] = { "<cmd>ChatGPTRun summarize<cr>", desc = "Summarize" },
    ["<leader>?f"] = { "<cmd>ChatGPTRun fix_bugs<cr>", desc = "Fix bugs" },
    ["<leader>?E"] = { "<cmd>ChatGPTRun explain_code<cr>", desc = "Explain code" },
    ["<leader>?a"] = { "<cmd>ChatGPTRun code_readability_analysis<cr>", desc = "Readability analysis" },
    ["<leader>?i"] = { "<cmd>ChatGPTEditWithInstructions<cr>", desc = "Edit with instruction" },
  },
  i = {
    -- signature help, fails silently so attach always
    ["<C-l>"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature help" },
    -- type template string
    ["<C-CR>"] = { "<++>", desc = "Insert template string" },
    ["<S-Tab>"] = { "<C-V><Tab>", desc = "Tab character" },
    -- date/time input
    ["<C-t>"] = { desc = "󰃰 Date/Time" },
    ["<C-t>n"] = { "<c-r>=strftime('%Y-%m-%d')<cr>", desc = "Y-m-d" },
    ["<C-t>x"] = { "<c-r>=strftime('%m/%d/%y')<cr>", desc = "m/d/y" },
    ["<C-t>f"] = { "<c-r>=strftime('%B %d, %Y')<cr>", desc = "B d, Y" },
    ["<C-t>X"] = { "<c-r>=strftime('%H:%M')<cr>", desc = "H:M" },
    ["<C-t>F"] = { "<c-r>=strftime('%H:%M:%S')<cr>", desc = "H:M:S" },
    ["<C-t>d"] = { "<c-r>=strftime('%Y/%m/%d %H:%M:%S -')<cr>", desc = "Y/m/d H:M:S -" },
  },
  -- terminal mappings
  t = {
    ["<C-n>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
    ["<esc><esc>"] = { "<C-\\><C-n>:q<cr>", desc = "Terminal quit" },
  },
  x = {
    -- better increment/decrement
    ["+"] = { "g<C-a>", desc = "Increment number" },
    ["-"] = { "g<C-x>", desc = "Descrement number" },
    -- line text-objects
    ["il"] = { "g_o^", desc = "Inside line text object" },
    ["al"] = { "$o^", desc = "Around line text object" },
    -- Easy-Align
    ga = { "<Plug>(EasyAlign)", desc = "Easy Align" },
    -- vim-sandwich
    ["s"] = "<Nop>",
  },
  o = {
    -- line text-objects
    ["il"] = { ":normal vil<cr>", desc = "Inside line text object" },
    ["al"] = { ":normal val<cr>", desc = "Around line text object" },
  },
}

-- add more text objects for "in" and "around"
for _, char in ipairs { "_", ".", ":", ",", ";", "|", "/", "\\", "*", "+", "%", "`", "?" } do
  for _, mode in ipairs { "x", "o" } do
    mappings[mode]["i" .. char] =
      { string.format(":<C-u>silent! normal! f%sF%slvt%s<CR>", char, char, char), desc = "between " .. char }
    mappings[mode]["a" .. char] =
      { string.format(":<C-u>silent! normal! f%sF%svf%s<CR>", char, char, char), desc = "around " .. char }
  end
end

return mappings
