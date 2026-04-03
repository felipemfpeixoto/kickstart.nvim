# PXTVIM

A personal Neovim configuration focused on a productive, fast, and IDE-like experience — without the bloat. Built on top of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and tailored for C#, TypeScript, Python, Lua, and C/C++ development.

## Features

- Full LSP support with auto-install via Mason
- Autocompletion powered by blink.cmp + LuaSnip
- Debugger (DAP) with .NET / C# support out of the box (macOS ARM64 included)
- Format on save with conform.nvim
- Fuzzy finding via Telescope + fzf-native
- Fast navigation with flash.nvim
- Yazi as an in-editor file manager
- Treesitter-based syntax highlighting, indentation, and folding
- Git integration with gitsigns + vim-fugitive
- Seamless tmux pane navigation
- Which-key for keymap discoverability
- Tokyo Night (night) colorscheme

## Directory Structure

```
~/.config/nvim/
├── init.lua                  # Entry point
└── lua/
    ├── config/
    │   ├── options.lua       # Vim options
    │   ├── keymaps.lua       # Global keymaps
    │   ├── autocmds.lua      # Autocommands
    │   └── lazy.lua          # Plugin manager bootstrap
    └── plugins/
        ├── lsp.lua           # LSP + Mason
        ├── completion.lua    # blink.cmp + LuaSnip
        ├── treesitter.lua    # Syntax / folding
        ├── formatting.lua    # conform.nvim
        ├── debug.lua         # nvim-dap + UI
        ├── roslyn.lua        # C# Roslyn LSP
        ├── telescope.lua     # Fuzzy finder
        ├── flash.lua         # Jump navigation
        ├── yazi.lua          # File manager
        ├── git.lua           # gitsigns + fugitive
        ├── ui.lua            # which-key
        ├── editor.lua        # mini.nvim, todo-comments, guess-indent
        ├── autopairs.lua     # Auto bracket/quote pairs
        ├── tmux-navigator.lua
        └── colorscheme.lua   # Tokyo Night
```

## Requirements

| Dependency | Purpose |
|---|---|
| Neovim >= 0.10 (latest stable) | Runtime |
| `git`, `make`, `gcc` / `clang` | Build tools |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Live grep in Telescope |
| [fd-find](https://github.com/sharkdp/fd) | File search |
| [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter) | Parser compilation |
| A [Nerd Font](https://www.nerdfonts.com/) | Icons throughout the UI |
| [yazi](https://github.com/sxyazi/yazi) | In-editor file manager |
| .NET SDK | C# / F# debugging via netcoredbg |

## Installation

```sh
# Back up any existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this config
git clone https://github.com/<your-username>/pxtvim.git ~/.config/nvim

# Start Neovim — lazy.nvim will bootstrap itself and install all plugins
nvim
```

Run `:Lazy` to monitor plugin installation status.

Mason will auto-install all LSP servers, formatters, and DAP adapters on first launch.

## Plugins

### LSP — `nvim-lspconfig` + Mason

Auto-installs and configures language servers:

| Language | Server |
|---|---|
| Lua | `lua_ls` |
| Python | `pyright` |
| TypeScript / JavaScript | `ts_ls` |
| C / C++ | `clangd` |
| C# (Roslyn) | `roslyn.nvim` |

### Completion — `blink.cmp` + `LuaSnip`

- Sources: LSP, path, snippets
- Signature help enabled
- `<C-y>` to accept, `<C-n>` / `<C-p>` to navigate

### Formatting — `conform.nvim`

Format on save. Manual format with `<leader>f`.

| Language | Formatter |
|---|---|
| Lua | stylua |
| Python | ruff_format |
| JS / TS / JSX / TSX | prettierd → prettier |
| C / C++ | clang-format |

### Debugging — `nvim-dap`

Supports C#, F#, and VB.NET via `netcoredbg`. On macOS ARM64, uses [netcoredbg-macOS-arm64.nvim](https://github.com/Cliffback/netcoredbg-macOS-arm64.nvim) for automatic adapter setup.

| Key | Action |
|---|---|
| `<F5>` | Start / Continue |
| `<F1>` | Step Into |
| `<F2>` | Step Over |
| `<F3>` | Step Out |
| `<leader>db` | Toggle Breakpoint |
| `<leader>dB` | Conditional Breakpoint |
| `<leader>du` | Toggle DAP UI |
| `<leader>dr` | Open REPL |
| `<leader>dl` | Run Last |
| `<leader>dq` | Terminate |

### Treesitter

Parsers installed: `bash`, `c`, `c_sharp`, `cpp`, `diff`, `html`, `javascript`, `typescript`, `tsx`, `lua`, `luadoc`, `markdown`, `python`, `query`, `vim`, `vimdoc`.

Folding is driven by Treesitter (`za` / `zc` / `zo`). All folds open by default.

### Telescope

Fuzzy finder with fzf-native for fast matching.

| Key | Action |
|---|---|
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep |
| `<leader>sw` | Grep current word |
| `<leader>sd` | Search diagnostics |
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search keymaps |
| `<leader>sc` | Search commands |
| `<leader>s.` | Recent files |
| `<leader>sr` | Resume last search |
| `<leader><leader>` | Open buffers |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader>sn` | Search Neovim config files |
| `grr` | LSP references |
| `grd` | LSP definition |
| `gri` | LSP implementation |
| `grt` | LSP type definition |
| `gO` | Document symbols |
| `gW` | Workspace symbols |

### Flash — fast navigation

| Key | Mode | Action |
|---|---|---|
| `s` | n / x / o | Jump to label |
| `S` | n / x / o | Treesitter-aware jump |
| `r` | o | Remote flash |
| `R` | o / x | Treesitter search |
| `<C-s>` | c | Toggle flash in search |

### Yazi — file manager

| Key | Action |
|---|---|
| `<leader>-` | Open yazi at current file |
| `<leader>cw` | Open yazi at cwd |
| `<C-Up>` | Resume last yazi session |

### Git

**gitsigns.nvim** — inline signs and hunk operations:

| Key | Action |
|---|---|
| `]c` / `[c` | Next / previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hR` | Reset buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff against index |
| `<leader>hD` | Diff against last commit |
| `<leader>tb` | Toggle inline blame |

**vim-fugitive** — full Git workflow from the command line (`:Git`, `:Gdiffsplit`, etc.)

### Tmux Navigator

`<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` move between Neovim splits and tmux panes seamlessly.

### UI & Editor Utilities

| Plugin | Purpose |
|---|---|
| `which-key.nvim` | Keymap popup on `<leader>` |
| `mini.ai` | Extended text objects (`va)`, `ci'`, `yinq`, …) |
| `mini.surround` | Add / delete / replace surroundings (`saiw)`, `sd'`, `sr)'`) |
| `mini.statusline` | Minimal statusline |
| `todo-comments.nvim` | Highlights `TODO`, `FIXME`, `NOTE`, etc. |
| `guess-indent.nvim` | Auto-detects file indentation |
| `nvim-autopairs` | Auto-closes brackets and quotes |
| `fidget.nvim` | LSP progress indicator |

## Key Options

| Option | Value |
|---|---|
| Leader key | `<Space>` |
| Indentation | 4 spaces (expandtab) |
| Clipboard | System clipboard (`unnamedplus`) |
| Colorscheme | `tokyonight-night` |
| Line numbers | Absolute + relative |
| Scroll offset | 10 lines |
| Folding | Treesitter expression, all open by default |
| Undo | Persistent undo file |

## Global Keymaps

| Key | Action |
|---|---|
| `<Esc>` | Clear search highlight |
| `<C-a>` | Select all |
| `<leader>q` | Open diagnostic quickfix list |
| `<leader>f` | Format buffer |
| `<leader>th` | Toggle inlay hints |
| `]b` / `[b` | Next / previous buffer |
| `<leader>bd` | Delete current buffer |
| `<leader>bD` | Delete all other buffers |
| `d` / `dd` / `D` / `c` | Delete / change using black-hole register (clipboard stays clean) |
| `grn` | LSP rename |
| `gra` | LSP code action |
| `grD` | LSP declaration |
