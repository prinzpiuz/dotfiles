# Using hm

`~/hm` is a Makefile that installs tools. It does not configure them; configuration is handled by chezmoi.

All commands run from `~/hm` (or use `make -C ~/hm <target>` from anywhere).

## Quick reference

| Command | What it does |
|---------|--------------|
| `make help` | List group targets |
| `make <package>` | Install or upgrade one tool, e.g. `make ripgrep` |
| `make <group>` | Install a group, e.g. `make cli` |
| `make dev` | cli, python, node, go-tools, rust-tools, editors, shell |
| `make desktop` | wm, desktop-apps, fonts, input-method, security |
| `make all` | dev, desktop, backup, finance, dotfiles |
| `./hm.sh` | fzf picker over individual packages (Tab to multi-select, Enter to install, Esc to quit) |
| `make update` | `sudo apt-get update` |
| `make clean` | Clear apt, cargo, uv, npm, and go caches |
| `make -n <target>` | Dry run: print the commands without running them |

Re-running a target upgrades the tool where the package manager supports it (apt, cargo, uv, go `@latest`, npm, curl installers).

## Groups

| Group | Targets |
|-------|---------|
| `cli` | ripgrep jq bat fzf htop fd maim fish tree-sitter-cli copyq tldr git git-extras inotify-tools smartmontools |
| `python` | uv ruff |
| `node` | prettier typescript bitwarden-cli |
| `go-tools` | goimports librespeed ssh-manager |
| `rust-tools` | stylua eza zoxide |
| `shell` | fish oh-my-fish fisher fish-plugins |
| `editors` | neovim |
| `fonts` | nerd-fonts fonts-jetbrains-mono fonts-firacode fonts-font-awesome fonts-noto-color-emoji fonts-powerline |
| `wm` | i3 i3status-rs rofi dunst autorandr arandr x11-xserver-utils feh picom xscreensaver gluqlo upower tlp greenclip betterlockscreen papirus-icon-theme arc-theme adw-gtk3 slick-greeter |
| `desktop-apps` | kitty gogh firefox-esr obsidian kdenlive kdeconnect voikko-fi hspell fam qt5-qmltooling-plugins phonon4qt5-backend-gstreamer spotify noisetorch bluetooth-battery |
| `security` | clamav mullvad tailscale bitwarden-cli |
| `backup` | restic resticprofile |
| `finance` | ledger hledger paisa |
| `vpn` | mullvad tailscale |
| `input-method` | ibus ibus-uniemoji python3-levenshtein varnam |

`make dotfiles` installs chezmoi and runs `chezmoi init --apply prinzpiuz`.

## Layout

```
hm/
  makefile        generators, custom install targets, groups, help
  hm.sh           fzf picker
  dev/            cli.mk python.mk node.mk go.mk rust.mk languages.mk
  desktop/        apps.mk wm.mk fonts.mk
```

## Adding a package

1. Append it to the right list in the relevant `.mk` file:

   | List | Install command |
   |------|-----------------|
   | `APT` | `sudo apt-get install -y` |
   | `CARGO` | `cargo install` |
   | `UV` | `uv tool install` |
   | `GO` | `go install <pkg>@latest` |
   | `NPM` | `sudo npm i -g` |
   | `PIP` | `pip install --break-system-packages` |

   ```makefile
   APT += newtool
   ```

2. If the package manager's name differs from the target name you want to type, add an override:

   ```makefile
   CARGO += fd
   PKG_fd := fd-find      # make fd -> cargo install fd-find
   ```

   Go packages need the full module path this way:

   ```makefile
   GO += goimports
   PKG_goimports := golang.org/x/tools/cmd/goimports
   ```

3. If it needs a curl or installer script, write a target by hand in `makefile` under "Custom installs":

   ```makefile
   .PHONY: newtool
   newtool:
   	@echo "installing/upgrading $@..."
   	@curl -fsSL https://example.com/install.sh | sh
   ```

4. Optionally add it to a group target in `makefile`.

5. Check it: `make -n newtool`.

## Adding a group

1. Add the target in `makefile` under "Group targets":

   ```makefile
   .PHONY: mygroup
   mygroup: tool-a tool-b
   ```

2. Add `mygroup` to `exclude_patterns` in `hm.sh`, otherwise it shows up in the picker as a package.
3. Optionally add it to `dev`, `desktop`, or `all`, and to the `help` output.

## Other notes

- Manual targets only print where to get the tool; nothing is installed: mullvad, obsidian, spotify, adw-gtk3, greenclip, gluqlo, betterlockscreen, ibus-uniemoji, varnam, gogh, paisa, noisetorch, bluetooth-battery.
- `make neovim` replaces `/opt/nvim-linux-x86_64` and symlinks `/usr/local/bin/nvim`.
- The whole `~/hm` directory is managed by chezmoi. Edit files through `chezmoi edit`, or run `chezmoi re-add` after editing in place; that commits and pushes to GitHub.
