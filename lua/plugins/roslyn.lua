return {
  {
    'seblyng/roslyn.nvim',
    ft = 'cs',
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- broad_search = false,  -- busca .sln em diretórios superiores ao cwd
      -- lock_target = false,   -- trava na solução escolhida após attach
      -- filewatching = 'auto', -- 'auto' | 'roslyn' | 'off'
    },
  },
}
