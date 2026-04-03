-- nvim-dap: Debug Adapter Protocol support with .NET (netcoredbg)

---@module 'lazy'
---@type LazySpec
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    { 'Cliffback/netcoredbg-macOS-arm64.nvim', cond = vim.loop.os_uname().sysname == 'Darwin' },
  },
  keys = {
    { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
    { '<F1>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
    { '<F2>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
    { '<F3>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
    { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Set Conditional Breakpoint' },
    { '<leader>du', function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },
    { '<leader>dr', function() require('dap').repl.open() end, desc = 'Debug: Open REPL' },
    { '<leader>dl', function() require('dap').run_last() end, desc = 'Debug: Run Last' },
    { '<leader>dq', function() require('dap').terminate() end, desc = 'Debug: Terminate' },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        'netcoredbg',
      },
    }

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- .NET / C# configuration via netcoredbg
    if vim.loop.os_uname().sysname == 'Darwin' then
      require('netcoredbg-macOS-arm64').setup(dap)
    else
      dap.adapters.coreclr = {
        type = 'executable',
        command = vim.fn.stdpath('data') .. '/mason/bin/netcoredbg',
        args = { '--interpreter=vscode' },
      }
    end

    dap.configurations.cs = {
      {
        type = 'coreclr',
        name = 'Launch (netcoredbg)',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to DLL: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
        cwd = vim.fn.getcwd(),
        env = {
          ASPNETCORE_ENVIRONMENT = 'Development',
          ASPNETCORE_URLS = 'http://localhost:8080',
        },
      },
      {
        type = 'coreclr',
        name = 'Attach (netcoredbg)',
        request = 'attach',
        processId = function()
          return require('dap.utils').pick_process()
        end,
      },
    }

    -- Apply the same config to F# and VB.NET
    dap.configurations.fsharp = dap.configurations.cs
    dap.configurations.vb = dap.configurations.cs
  end,
}
