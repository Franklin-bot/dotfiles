local function setup()
    local dap = require('dap')
    local ui = require('dapui')

    -- require("dap").set_log_level("TRACE")

    dap.adapters.lldb = {
      type = "executable",
      command = "/opt/homebrew/opt/llvm/bin/lldb-dap",
    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        runInTerminal = true
      },
    }

    ui.setup({
        layouts = {  {
        elements = { {
            id = "console",
            size = 1
          } },
        position = "right",
        size = 40,
      } },
    })

    vim.api.nvim_set_hl(0, "debug-red",   { fg = "#d0679d" })
    vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
    vim.keymap.set("n", "<space>?", function()
        ui.eval(nil, { enter = true })
    end)
    vim.keymap.set("n", "<space>ds", function()
        ui.float_element("scopes",
        {enter = true,
        position = "center",
        width = 80,
        height = 20
    })
    end)



    vim.keymap.set("n", "<leader>dj", dap.continue)
    vim.keymap.set("n", "<F2>", dap.step_into)
    vim.keymap.set("n", "<F3>", dap.step_over)
    vim.keymap.set("n", "<F4>", dap.step_out)
    vim.keymap.set("n", "<F5>", dap.step_back)
    vim.keymap.set("n", "<F6>", dap.restart)
    vim.keymap.set("n", "<space>dq", ui.close)
    vim.fn.sign_define('DapBreakpoint', {text='󰃤', texthl='debug-red', linehl='', numhl=''})
    vim.fn.sign_define('DapStopped', {text='', texthl='debug-red', linehl='', numhl=''})

    dap.listeners.before.attach.dapui_config = function()
        ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
    end
end


local M = {
    'mfussenegger/nvim-dap',
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio"
    },
    config = setup,
}

return M
