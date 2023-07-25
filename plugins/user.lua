return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    event = "User AstroFile",
    cmd = { "TodoQuickFix" },
    keys = {
      { "<leader>T", "<cmd>TodoTelescope<cr>", desc = "Open TODOs in Telescope" }
    }
  },
  {
    "f-person/git-blame.nvim",
    event = "User AstroFile"
  },
  {
    "andweeb/presence.nvim",
    opts = {
      -- General options
      auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
      neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
      main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
      client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
      log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
      debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
      enable_line_number  = false,                      -- Displays the current line number instead of the current project
      blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
      buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
      file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
      show_time           = true,                       -- Show the timer

      -- Rich Presence text options
      editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
      file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
      git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
      plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
      reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
      workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
      line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
    },
    event = { "VeryLazy", "User AstroFile" },
  },
  {
    "Pocco81/auto-save.nvim",
    -- TODO: See if this has to be different or simpler (it just works for now)
    opts = {
      enabled = true,
      execution_message = {
        message = function()
          return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
        dim = 0.18,
        cleaning_interval = 1250,
      },
      trigger_events = {"InsertLeave", "TextChanged"},
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")

        if
          fn.getbufvar(buf, "&modifiable") == 1 and
          utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
          return true
        end
        return false
      end,
      write_all_buffers = false,
      debounce_delay = 135, -- saves the file every `x` milliseconds
      callbacks = {
        enabling = nil,
        disabling = nil,
        before_asserting_save = nil,
        before_saving = nil,
        after_saving = nil
      }
    },
    event = "User AstroFile"
  },
  {
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      local home = vim.fn.expand("$HOME")
      require("chatgpt").setup({
        api_key_cmd = "cat " .. home .. "/nvim_chatgpt_key.txt"
      })
    end,
    event = "VeryLazy",
  }
}
