local dap = require('dap')
local dapui = require("dapui")

dap.adapters.coreclr = {
    type = 'executable',
    command = 'netcoredbg',    
    args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "Launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to dll > ', vim.fn.getcwd() .. '/bin/Debug/net10.0/', 'file')
        end,
        stopOnEntry = true,
    },
}

dapui.setup();

dap.listeners.before.event_terminated["dapui_config"] = close_dap_ui
dap.listeners.before.event_exited["dapui_config"] = close_dap_ui

dap.listeners.after.event_terminated["reset_nerdtree_width"] = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
        if bufname:match("NERD_tree_") then
            vim.api.nvim_set_current_win(win)
            vim.cmd("vertical resize 35")
            vim.cmd("wincmd p")
            break
        end
    end
end

dap.listeners.after.event_exited["reset_nerdtree_width"] = dap.listeners.after.event_terminated["reset_nerdtree_width"]


vim.api.nvim_set_keymap('n', '<F5>', '<Cmd>lua require"dap".continue()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<F10>', '<Cmd>lua require"dap".step_over()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<F11>', '<Cmd>lua require"dap".step_into()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<F12>', '<Cmd>lua require"dap".step_out()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<Leader>b', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<Leader>B', '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<Leader>dr', '<Cmd>lua require"dap".repl.open()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<Leader>dl', '<Cmd>lua require"dap".run_last()<CR>', { noremap=true, silent=true })
