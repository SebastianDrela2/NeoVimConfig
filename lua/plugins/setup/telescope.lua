require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
        ["<CR>"] = function(prompt_bufnr)
          require('telescope.actions').select_default(prompt_bufnr)
          vim.cmd(":only")
        end,
      },
      n = {
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
        ["<CR>"] = function(prompt_bufnr)
          require('telescope.actions').select_default(prompt_bufnr)
          vim.cmd(":only")
        end,
      }
    },
    vimgrep_arguments = {
      "rg", "--color=never", "--no-heading", "--with-filename",
      "--line-number", "--column", "--smart-case", "--hidden", "--no-ignore"
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case"
    }
  }
})

if vim.fn.has('win32') == 1 then
  local Job = require('plenary.job')
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local previewers = require('telescope.previewers')
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  
  function _G.everything_live_search()
    pickers.new({}, {
      prompt_title = "Everything Search",
      finder = finders.new_dynamic({
        fn = function(prompt)
          if not prompt or prompt == "" then return {} end

          local results = {}
          Job:new({
            command = "es.exe",
            args = { "/a-d", "-n", "50", prompt },
            on_stdout = function(_, line)
              table.insert(results, line)
            end,
            on_stderr = function(_, err)
              if err and err ~= "" then
                vim.schedule(function()
                  vim.notify("[Everything] Error: " .. err, vim.log.levels.ERROR)
                end)
              end
            end,
          }):sync()
          return results
        end
      }),
      sorter = conf.generic_sorter({}),
      previewer = previewers.cat.new({}),
      layout_config = { width = 0.9, height = 0.8 },
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection and selection[1] then
            vim.cmd('edit ' .. vim.fn.fnameescape(selection[1]))
            vim.cmd('only')
          end
        end)
        return true
      end,
    }):find()
  end

  vim.api.nvim_set_keymap('n', 'fe', '<cmd>lua everything_live_search()<CR>', { noremap = true, silent = true })

  vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "LSP Code Action" })

  vim.schedule(function()
    vim.notify("[Everything] Search keymap 'fe' is now active", vim.log.levels.INFO)
  end)
end
