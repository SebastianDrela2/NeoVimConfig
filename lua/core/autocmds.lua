local autocmd = vim.api.nvim_create_autocmd

autocmd('BufWritePre', {
  pattern = {'*.c', '*.cpp', '*.h', '*.hpp'},
  command = 'silent! Neoformat'
})

autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.rs',
  command = 'set filetype=rust'
})

autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.cs',
  command = 'set filetype=cs'
})

autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, {focus=false})
  end
})
