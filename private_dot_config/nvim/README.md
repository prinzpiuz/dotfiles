# Neovim Configuration

A personal Neovim setup built on [lazy.nvim](https://github.com/folke/lazy.nvim), with LSP, DAP, formatting, and fuzzy finding configured per language.

## Requirements

### Neovim

- Neovim >= 0.12

### System dependencies

| Tool | Purpose |
|------|---------|
| `git` | Plugin manager bootstrap |
| `make` | Building telescope-fzf-native and LuaSnip |
| `gcc` or `clang` | Compiling native extensions |
| `node` + `npm` | TypeScript LSP and prettier |
| `python3` | Python LSP and DAP |
| `go` | Go LSP (`gopls`) and debugger (`delve`) |
| `flutter` + `dart` | Flutter/Dart LSP, formatting, and debugging |
| `rust` + `cargo` | Rust LSP (`rust_analyzer`) |
| `ripgrep` | Telescope live grep |
| `fd` | Telescope file finder (faster alternative to find) |
| `chromium` or `google-chrome` | Chrome DAP for JS/TS debugging |
| A [Nerd Font](https://www.nerdfonts.com/) | Icons throughout the UI |
| tree-sitter-cli | cargo install tree-sitter-cli |

### Automatically installed via Mason

The following are installed automatically on first launch — no manual steps needed.

**LSP servers:** `clangd`, `gopls`, `pyright`, `rust_analyzer`, `dockerls`, `taplo`, `bashls`, `docker_compose_language_service`, `yamlls`, `ruff`, `lua_ls`

**Formatters:** `stylua`, `prettierd`, `prettier`, `shfmt`

**DAP adapters:** `delve` (Go), `debugpy` (Python), `chrome` (JS/TS)

## Installation

```bash
git clone <your-repo-url> ~/.config/nvim
nvim
```

lazy.nvim will bootstrap itself and install all plugins on the first launch.

## Structure

```
~/.config/nvim/
├── init.lua                  # Entry point: loads config modules and lazy.nvim
└── lua/
    ├── config/
    │   ├── options.lua       # Vim options (tabs, line numbers, clipboard, etc.)
    │   ├── keymaps.lua       # Global keymaps and diagnostic config
    │   └── autocmds.lua      # Autocommands
    └── plugins/              # One file per plugin, auto-discovered by lazy.nvim
        ├── lsp.lua           # LSP + Mason stack
        ├── treesitter.lua    # Syntax highlighting and text objects
        ├── blink-cmp.lua     # Autocompletion + LuaSnip snippets
        ├── conform.lua       # Formatting on save
        ├── debug.lua         # DAP debugger (Go, Python, JS/TS, Flutter)
        ├── telescope.lua     # Fuzzy finder
        ├── gitsigns.lua      # Git hunk signs and actions
        ├── oil.lua           # File explorer
        ├── mini.lua          # mini.ai, mini.surround, mini.statusline
        ├── which-key.lua     # Keymap hints
        ├── todo-comments.lua # Highlight TODO/FIXME/NOTE in comments
        ├── autopairs.lua     # Auto-close brackets and quotes
        ├── typescript-tools.lua # Enhanced TypeScript LSP
        ├── flutter-tools.lua # Flutter development tools
        └── guess-indent.lua  # Auto-detect indentation
```

## Key Mappings

`<leader>` is `Space`.

### General

| Key | Action |
|-----|--------|
| `<leader>e` | Open file explorer (Oil) |
| `<leader>f` | Find files |
| `<leader>cf` | Format buffer |
| `<leader>z` | Toggle Zen mode |
| `<Esc>` | Clear search highlights |
| `<leader>q` | Open diagnostics quickfix list |
| `<C-h/j/k/l>` | Navigate between splits |

### Search (Telescope)

| Key | Action |
|-----|--------|
| `<leader>sh` | Search help tags |
| `<leader>sf` | Search files |
| `<leader>sg` | Live grep |
| `<leader>sd` | Search diagnostics |
| `<leader>sw` | Search current word |
| `<leader>sr` | Resume last search |
| `<leader>s.` | Search recent files |
| `<leader>sc` | Search commands |
| `<leader><leader>` | Search open buffers |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader>s/` | Live grep in open files |
| `<leader>sn` | Search Neovim config files |

### LSP

| Key | Action |
|-----|--------|
| `grn` | Rename symbol |
| `gra` | Code action |
| `grD` | Go to declaration |
| `grd` | Go to definition |
| `grr` | Go to references |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `gO` | Document symbols |
| `gW` | Workspace symbols |
| `<leader>th` | Toggle inlay hints |

### Git (Gitsigns)

| Key | Action |
|-----|--------|
| `]c` / `[c` | Next / previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff against index |
| `<leader>tb` | Toggle inline blame |
| `<leader>tw` | Toggle word diff |

### Debugging (DAP)

| Key | Action |
|-----|--------|
| `<F5>` | Start / continue |
| `<F1>` | Step into |
| `<F2>` | Step over |
| `<F3>` | Step out |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Set conditional breakpoint |
| `<F7>` | Toggle debug UI |
