# System Setup (hm)

A single Makefile that declares every tool on the system, grouped by purpose.

Inspired by [Home Maker](https://thottingal.in/blog/2026/03/29/home-maker/).

## Structure

```
hm/
├── Makefile          # Main file — generators, custom installs, groups
├── hm.sh             # Interactive fuzzy installer (uses fzf)
├── dev/
│   ├── cli.mk        # CLI tools (ripgrep, fzf, bat, eza, etc.)
│   ├── python.mk     # Python tools (ruff via uv)
│   ├── node.mk       # Node tools (prettier, typescript)
│   ├── go.mk         # Go tools (goimports)
│   ├── rust.mk       # Rust-specific tools
│   └── languages.mk  # Language runtimes (python3, nodejs, gcc)
└── desktop/
    ├── apps.mk       # Desktop apps (firefox, kdenlive, kdeconnect)
    ├── wm.mk         # Window manager stack (i3, rofi, dunst, picom)
    └── fonts.mk      # Fonts (JetBrains Mono, FiraCode, Nerd Fonts)
```

## Usage

```bash
# Install everything
make all

# Install only dev tools
make dev

# Install only desktop/WM stack
make desktop

# Install a single package
make ripgrep
make neovim
make kitty

# Install a group
make cli
make fonts
make shell
make wm

# Interactive fuzzy installer
./hm.sh

# Clean all caches
make clean

# See all available groups
make help
```

## Adding a new package

### If the package manager name matches the target name:

```makefile
# In the relevant .mk file
APT += newpackage
```

### If the package name differs:

```makefile
CARGO += fd
PKG_fd := fd-find
```

### If it needs a custom install script:

Add a target directly in the `Makefile`:

```makefile
.PHONY: newtool
newtool:
	@echo "installing/upgrading $@..."
	@curl -L https://example.com/install.sh | sh
```

### Package managers supported:

- `APT` — `sudo apt-get install -y`
- `CARGO` — `cargo install`
- `UV` — `uv tool install`
- `GO` — `go install`
- `NPM` — `sudo npm i -g`
- `PIP` — `pip install --break-system-packages`

## Note

This only manages tool installation, not configuration.
Dotfiles and configs are managed separately by chezmoi.
Run `make dotfiles` to initialize chezmoi with your dotfiles repo.
