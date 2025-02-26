lvim.log.level = "warn"
vim.g.copilot_assume_mapped = true
lvim.format_on_save.enabled = true
lvim.keys.insert_mode["jk"] = "<esc>"
vim.opt.clipboard = "unnamedplus"
local colorcolumn_str = "80"
for i = 81, 500 do
  colorcolumn_str = colorcolumn_str .. "," .. tostring(i)
end
vim.opt.colorcolumn = colorcolumn_str

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "typescript",
  "rust",
  "json",
  "tsx",
  "css",
  "yaml"
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "rustfmt",
    extra_args = { "--edition", "2021" },
    filetypes = { "rust" }
  }
}

lvim.plugins = {
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      require("gitblame").setup { enabled = false }
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "itchyny/vim-cursorword",
    event = { "BufEnter", "BufNewFile" },
    config = function()
      vim.api.nvim_command("augroup user_plugin_cursorword")
      vim.api.nvim_command("autocmd!")
      vim.api.nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
      vim.api.nvim_command("autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
      vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
      vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
      vim.api.nvim_command("augroup END")
    end
  },
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_no_tab_map = true
    end
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function()
        require("copilot").setup {
          suggestion = { enabled = false },
          panel = { enabled = true },
        }
      end, 0)
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end
  }
}
