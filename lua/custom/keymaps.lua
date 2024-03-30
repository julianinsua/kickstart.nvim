vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- [V]IM keybindings
vim.keymap.set('n', '<leader>vb', ':bnext<cr>', { silent = true, desc = 'buffer next' })
vim.keymap.set('n', '<leader>vB', ':bprevious<cr>', { silent = true, desc = 'buffer previous' })
vim.keymap.set('n', '<leader>vt', ':tabnext<cr>', { silent = true, desc = 'tab next' })
vim.keymap.set('n', '<leader>vT', ':tabprevious<cr>', { silent = true, desc = 'tab previous' })
vim.keymap.set('n', '<leader>vnv', '<C-w>v', { desc = 'new vertical split', silent = true })
vim.keymap.set('n', '<leader>vnx', '<C-w>s', { desc = 'new horizontal split', silent = true })
vim.keymap.set('n', '<leader>vnt', '<cmd>tabnew<CR>', { desc = 'new tab', silent = true })
vim.keymap.set('n', '<leader>vnb', '<cmd>enew<CR>', { desc = 'new buffer', silent = true })

-- Exit terminal mode
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- NAVIGATION
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = 'Better navigation on wordwrap lines' })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = 'Better navigation on wordwrap lines' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader><C-q>', ':bdelete!<cr>', { silent = true, noremap = true, desc = 'close current buffer' })
vim.keymap.set('n', '<leader>q', ':x<cr>', { desc = 'quit', silent = true })

-- save all with in normal mode and Ctrl+s in insert mode
vim.keymap.set('n', '<c-s>', '<esc>:wa<cr>', { desc = 'Save all', silent = true })
vim.keymap.set('i', '<c-s>', '<esc>:wa<cr>', { desc = 'Save all', silent = true })

-- move splits around with Ctrl+H,J,K,L
vim.keymap.set('n', '<leader>H', '<C-w>H', { noremap = true })
vim.keymap.set('n', '<leader>J', '<C-w>J', { noremap = true })
vim.keymap.set('n', '<leader>K', '<C-w>K', { noremap = true })
vim.keymap.set('n', '<leader>L', '<C-w>L', { noremap = true })

-- auto resize splits with alt+= [normal mode]
vim.keymap.set('n', '<m-=>', '<c-w>=')
vim.keymap.set('n', '<m-j>', '<c-w>+')
vim.keymap.set('n', '<m-k>', '<c-w>-')
vim.keymap.set('n', '<m-l>', '<c-w>>')
vim.keymap.set('n', '<m-h>', '<c-w><')

-- Proper indentation when editing empty lines
vim.keymap.set('n', 'i', function()
  if #vim.fn.getline '.' == 0 then
    return '"_cc'
  else
    return 'i'
  end
end, { expr = true })
vim.keymap.set('n', 'I', function()
  if #vim.fn.getline '.' == 0 then
    return '"_cc'
  else
    return 'I'
  end
end, { expr = true })
vim.keymap.set('n', 'a', function()
  if #vim.fn.getline '.' == 0 then
    return '"_cc'
  else
    return 'a'
  end
end, { expr = true })
vim.keymap.set('n', 'A', function()
  if #vim.fn.getline '.' == 0 then
    return '"_cc'
  else
    return 'A'
  end
end, { expr = true })

-- Don't cut empty lines to the registry when using "dd"
vim.keymap.set('n', 'dd', function()
  if vim.api.nvim_get_current_line():match '^%s*$' then
    return '"_dd'
  else
    return 'dd'
  end
end, { expr = true })

-- Start from scratch
vim.keymap.set('n', '<leader>00', function()
  vim.cmd '%bdelete'
  vim.cmd 'G checkout main'
  vim.cmd 'G pull'
end, { silent = true, desc = 'Blank slate protocol' })

-- Global lookup on obsidian vault
vim.keymap.set('n', '<leader>of', '<cmd>Telescope find_files cwd=~/Dropbox/obsidian-vault/<CR>')
