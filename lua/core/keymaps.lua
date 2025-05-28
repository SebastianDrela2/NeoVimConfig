local keymap = vim.keymap

vim.g.VM_leader = '\\'
vim.g.VM_maps = {
  ['Add Cursor Down'] = '<C-j>',
  ['Add Cursor Up'] = '<C-k>',
  ['Exit'] = '<C-c>'
}

keymap.set('n', '<C-f>', function()
  local cur_file_dir = vim.fn.expand('%:p:h')
  vim.cmd('lcd ' .. vim.fn.fnameescape(cur_file_dir))
  vim.cmd('NERDTreeToggle ' .. vim.fn.fnameescape(cur_file_dir))
  
  if vim.fn.bufwinnr('NERD_tree_1') ~= -1 then
    vim.cmd('NERDTreeFocus')
  end
end, { silent = true })

keymap.set('n', '<C-x>', function()
	vim.cmd('NERDTreeFocus')
end)

keymap.set('n', '<leader>f', ':Neoformat<CR>', { silent = true })

keymap.set('n', '<S-Tab>', ':FloatermToggle<CR>', { silent = true })
keymap.set('t', '<S-Tab>', '<C-\\><C-n>:FloatermToggle<CR>', { silent = true })

keymap.set('n', '<C-c>', ':nohlsearch<CR>"+y', { silent = true })
keymap.set('v', '<C-c>', '"+y:nohlsearch<CR>', { silent = true })
keymap.set('t', '<Esc>', ':noh<CR><Esc>', { silent = true })

keymap.set('n', 'ff', '<cmd>lua require(\'telescope.builtin\').find_files({ cwd = vim.fn.expand(\'%:p:h\'), no_ignore = true, hidden = true })<CR>')
keymap.set('n', 'fg', '<cmd>lua require(\'telescope.builtin\').git_files({ cwd = vim.fn.expand(\'%:p:h\') })<CR>')
keymap.set('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files({ cwd = vim.fn.expand(\'%:p:h\') })<CR>')
keymap.set('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep({ cwd = vim.fn.expand(\'%:p:h\') })<CR>')
keymap.set('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<CR>')
keymap.set('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<CR>')