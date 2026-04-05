return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nsidorenco/neotest-vstest', -- move pra cá como dependência
    },
    keys = {
      { '<leader>tt', function() require('neotest').run.run() end, desc = '[T]est: run nearest' },
      { '<leader>tf', function() require('neotest').run.run(vim.fn.expand '%') end, desc = '[T]est: run file' },
      { '<leader>ts', function() require('neotest').run.stop() end, desc = '[T]est: stop' },
      { '<leader>to', function() require('neotest').output.open { enter = true } end, desc = '[T]est: output' },
      { '<leader>tO', function() require('neotest').output_panel.toggle() end, desc = '[T]est: output panel' },
      { '<leader>tp', function() require('neotest').summary.toggle() end, desc = '[T]est: summary panel' },
      { '<leader>td', function() require('neotest').run.run { strategy = 'dap' } end, desc = '[T]est: debug nearest' },
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-vstest',
        },
      }
    end,
  },
}
