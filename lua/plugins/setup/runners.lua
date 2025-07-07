local M = {}

function RunRust()
  local cmd = 'cargo run'
  vim.cmd('FloatermNew --name=runner --wintype=float --cwd=' .. vim.fn.expand('%:p:h') .. ' ' .. cmd)
end

function RunCpp()
  local source_file = vim.fn.expand('%')
  local output_file = vim.fn.expand('%:r') .. '.exe'
  local compile_cmd = 'clang++ -std=c++23 ' .. source_file .. ' -o ' .. output_file
  local run_cmd = 'cmd /c "' .. output_file .. ' & pause"'
  vim.cmd('silent! FloatermKill runner')
  vim.cmd('FloatermNew --name=runner --wintype=float --cwd=' .. vim.fn.expand('%:p:h') .. ' ' .. compile_cmd .. ' && ' .. run_cmd)
end

function RunCSharp()
  local current_file_dir = vim.fn.expand('%:p:h')
  local search_path = current_file_dir .. ';' .. vim.fn.fnamemodify(current_file_dir, ':h:h')
  
  local proj_file = vim.fn.findfile('*.csproj', search_path)
  
  if proj_file == '' then
    local parent_dir = vim.fn.fnamemodify(current_file_dir, ':h')
    local proj_files = vim.fn.split(vim.fn.glob(parent_dir .. '/**/*.csproj', 1), '\n')
    if #proj_files > 0 then
      proj_file = proj_files[1]
    end
  end

  if proj_file == '' then
    print("No .csproj file found in project structure!")
    return
  end

  local project_dir = vim.fn.fnamemodify(proj_file, ':h')
  print("Found project at: " .. project_dir)
  
  vim.cmd('silent! FloatermKill runner')
  vim.cmd('FloatermNew --name=runner --wintype=float --cwd=' .. project_dir .. ' dotnet run')
end

function RunCode()
  local ft = vim.bo.filetype
  if ft == 'rust' then
    RunRust()
  elseif ft == 'cpp' or ft == 'c' then
    RunCpp()
  elseif ft == 'cs' then
    RunCSharp()
  else
    print("No runner configured for filetype: " .. ft)
  end
end

vim.api.nvim_set_keymap('n', '<S-F5>', '<cmd>lua RunCode()<CR>', { noremap = true, silent = true })

return M
