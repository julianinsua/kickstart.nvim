vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = 'Better navigation on wordwrap lines' })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = 'Better navigation on wordwrap lines' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- navigate split buffers using space n,N close with space Q
vim.keymap.set('n', '<leader>n', ':bnext<cr>', { silent = true, desc = 'navigate to next split buffers' })
vim.keymap.set('n', '<leader>N', ':bprevious<cr>', { silent = true, desc = 'navigate to previous split buffers' })
vim.keymap.set('n', '<leader>Q', ':bdelete!<cr>', { silent = true, noremap = true, desc = 'close current buffer' })

-- save all with in normal mode and Ctrl+s in insert mode
vim.keymap.set('n', '<c-s>', '<esc>:wa<cr>', { desc = 'Save all', silent = true })
vim.keymap.set('i', '<c-s>', '<esc>:wa<cr>', { desc = 'Save all', silent = true })

--create splits with space v (vertical) and space V (horizontal), close them with leader q
vim.keymap.set('n', '<leader>v', '<C-w>v', { desc = 'split vertically', silent = true })
vim.keymap.set('n', '<leader>x', '<C-w>s', { desc = 'split horizontally', silent = true })
vim.keymap.set('n', '<leader>q', ':x<cr>', { desc = 'quit', silent = true })

-- move splits around with Ctrl+H,J,K,L
vim.keymap.set('n', '<leader>H', '<C-w>H', { noremap = true })
vim.keymap.set('n', '<leader>J', '<C-w>J', { noremap = true })
vim.keymap.set('n', '<leader>K', '<C-w>K', { noremap = true })
vim.keymap.set('n', '<leader>L', '<C-w>L', { noremap = true })

-- auto resize splits with alt+= [normal mode]
vim.keymap.set('n', '<m-=>', '<c-w>=')

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
