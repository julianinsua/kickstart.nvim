return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    completion = {
      nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
    },
    daily_notes = {
      folder = 'Daily',
    },
    workspaces = {
      {
        name = 'personal',
        path = '~/Dropbox/obsidian-vault/',
      },
    },
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ['<leader>ch'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { desc = '[O]bsidian [CH]eckbox toggle', buffer = true },
      },
      -- Open today note
      ['<leader>ot'] = {
        action = function()
          -- return require('obsidian').commands.today()
          vim.cmd 'ObsidianToday'
        end,
        opts = { desc = '[O]bsidian Open [T]oday note', buffer = true },
      },
      -- Open Dailies note picker
      ['<leader>od'] = {
        action = function()
          -- return require('obsidian').commands.today()
          vim.cmd 'ObsidianDailies'
        end,
        opts = { desc = '[O]bsidian Open [D]aily notes', buffer = true },
      },
      -- Open Incomming links
      ['<leader>oli'] = {
        action = function()
          -- return require('obsidian').commands.today()
          vim.cmd 'ObsidianBacklinks'
        end,
        opts = { desc = '[O]bsidian Open [L]inks [O]ut of current note', buffer = true },
      },
      -- Open Outgoing links
      ['<leader>olo'] = {
        action = function()
          -- return require('obsidian').commands.today()
          vim.cmd 'ObsidianLinks'
        end,
        opts = { desc = '[O]bsidian Open [L]inks [O]utgoing', buffer = true },
      },
    },
  },
}
