# =============================================================================
# System Setup Makefile
# Declares every tool on the system, grouped by purpose.
# Inspired by: https://thottingal.in/blog/2026/03/29/home-maker/
#
# Usage:
#   make all          - Install everything
#   make dev          - Install dev tools only
#   make desktop      - Install desktop apps only
#   make <package>    - Install a single package
#   ./hm.sh           - Interactive fuzzy installer
# =============================================================================

# Include all module files
include dev/cli.mk
include dev/python.mk
include dev/node.mk
include dev/go.mk
include dev/rust.mk
include dev/languages.mk
include desktop/apps.mk
include desktop/wm.mk
include desktop/fonts.mk

# =============================================================================
# Package manager commands
# =============================================================================
APT_INSTALL   := sudo apt-get install -y
CARGO_INSTALL := cargo install
UV_INSTALL    := uv tool install
GO_INSTALL    := go install
NPM_INSTALL   := sudo npm i -g
PIP_INSTALL   := pip install --break-system-packages

# =============================================================================
# Helper functions
# =============================================================================
# Split name@version
pkg-name    = $(firstword $(subst @, ,$(1)))
pkg-version = $(word 2,$(subst @, ,$(1)))
# Resolve PKG_ overrides (e.g., PKG_fd := fd-find)
pkg-pkgname = $(or $(PKG_$(call pkg-name,$(1))),$(call pkg-name,$(1)))

# =============================================================================
# Target generators — one per package manager
# =============================================================================
define gen-apt
.PHONY: $(call pkg-name,$(1))
$(call pkg-name,$(1)):
	@echo "installing/upgrading $$@..."
	@$(APT_INSTALL) $(call pkg-pkgname,$(1))
endef

define gen-cargo
.PHONY: $(call pkg-name,$(1))
$(call pkg-name,$(1)):
	@echo "installing/upgrading $$@..."
	@$(CARGO_INSTALL) $(call pkg-pkgname,$(1))
endef

define gen-uv
.PHONY: $(call pkg-name,$(1))
$(call pkg-name,$(1)):
	@echo "installing/upgrading $$@..."
	@$(UV_INSTALL) $(call pkg-pkgname,$(1))
endef

define gen-go
.PHONY: $(call pkg-name,$(1))
$(call pkg-name,$(1)):
	@echo "installing/upgrading $$@..."
	@$(GO_INSTALL) $(call pkg-pkgname,$(1))@latest
endef

define gen-npm
.PHONY: $(call pkg-name,$(1))
$(call pkg-name,$(1)):
	@echo "installing/upgrading $$@..."
	@$(NPM_INSTALL) $(call pkg-pkgname,$(1))
endef

define gen-pip
.PHONY: $(call pkg-name,$(1))
$(call pkg-name,$(1)):
	@echo "installing/upgrading $$@..."
	@$(PIP_INSTALL) $(call pkg-pkgname,$(1))
endef

# =============================================================================
# Expand lists into targets
# =============================================================================
$(foreach p,$(APT),$(eval $(call gen-apt,$(p))))
$(foreach p,$(CARGO),$(eval $(call gen-cargo,$(p))))
$(foreach p,$(UV),$(eval $(call gen-uv,$(p))))
$(foreach p,$(GO),$(eval $(call gen-go,$(p))))
$(foreach p,$(NPM),$(eval $(call gen-npm,$(p))))
$(foreach p,$(PIP),$(eval $(call gen-pip,$(p))))

# =============================================================================
# Custom installs — tools not in any package manager
# =============================================================================
.PHONY: chezmoi
chezmoi:
	@echo "installing/upgrading $@..."
	@sh -c "$$(curl -fsLS get.chezmoi.io)"

.PHONY: neovim
neovim:
	@echo "installing/upgrading $@..."
	@curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	@sudo rm -rf /opt/nvim-linux-x86_64
	@sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
	@sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
	@rm -f nvim-linux-x86_64.tar.gz

.PHONY: kitty
kitty:
	@echo "installing/upgrading $@..."
	@curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

.PHONY: uv
uv:
	@echo "installing/upgrading $@..."
	@curl -LsSf https://astral.sh/uv/install.sh | sh

.PHONY: oh-my-fish
oh-my-fish:
	@echo "installing/upgrading $@..."
	@curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

.PHONY: fisher
fisher:
	@echo "installing/upgrading $@..."
	@fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

.PHONY: fish-plugins
fish-plugins: fisher
	@echo "installing fish plugins..."
	@fish -c "fisher install patrickf1/fzf.fish"
	@fish -c "fisher install meaningful-ooo/sponge"
	@fish -c "fisher install franciscolourenco/done"
	@fish -c "fisher install ilancosman/tide@v6"

.PHONY: homebrew
homebrew:
	@echo "installing/upgrading $@..."
	@/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: tailscale
tailscale:
	@echo "installing/upgrading $@..."
	@curl -fsSL https://tailscale.com/install.sh | sh

.PHONY: mullvad
mullvad:
	@echo "installing/upgrading $@..."
	@echo "Download .deb from https://mullvad.net/download/linux and install with: sudo dpkg -i <file>.deb"

.PHONY: librespeed
librespeed:
	@echo "installing/upgrading $@..."
	@$(GO_INSTALL) github.com/librespeed/speedtest-cli/cmd/librespeed-cli@latest

.PHONY: nerd-fonts
nerd-fonts:
	@echo "installing FiraCode Nerd Font..."
	@mkdir -p ~/.local/share/fonts
	@cd ~/.local/share/fonts && \
		wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip && \
		unzip -o FiraCode.zip && \
		rm FiraCode.zip
	@fc-cache -fv

.PHONY: bitwarden-cli
bitwarden-cli:
	@echo "installing/upgrading $@..."
	@$(NPM_INSTALL) @bitwarden/cli

.PHONY: ssh-manager
ssh-manager:
	@echo "installing/upgrading $@..."
	@$(GO_INSTALL) github.com/omegion/ssh-manager@latest

.PHONY: resticprofile
resticprofile:
	@echo "installing/upgrading $@..."
	@curl -sfL https://raw.githubusercontent.com/creativeprojects/resticprofile/master/install.sh | sh

.PHONY: slick-greeter
slick-greeter:
	@echo "installing/upgrading $@..."
	@$(APT_INSTALL) slick-greeter lightdm

.PHONY: dotfiles
dotfiles: chezmoi
	@echo "initializing dotfiles..."
	@chezmoi init --apply prinzpiuz

# =============================================================================
# Group targets
# =============================================================================
.PHONY: cli
cli: ripgrep jq bat fzf htop fd maim fish tree-sitter-cli copyq

.PHONY: python
python: uv ruff

.PHONY: node
node: prettier typescript bitwarden-cli

.PHONY: go-tools
go-tools: goimports librespeed ssh-manager

.PHONY: rust-tools
rust-tools: stylua eza zoxide

.PHONY: shell
shell: fish oh-my-fish fisher fish-plugins

.PHONY: fonts
fonts: nerd-fonts jetbrains-mono font-awesome

.PHONY: wm
wm: i3 i3status-rust rofi dunst autorandr feh picom xscreensaver

.PHONY: desktop-apps
desktop-apps: kitty firefox obsidian kdenlive kdeconnect spotify

.PHONY: security
security: clamav mullvad tailscale bitwarden-cli

.PHONY: backup
backup: restic resticprofile

.PHONY: editors
editors: neovim

.PHONY: vpn
vpn: mullvad tailscale

.PHONY: input-method
input-method: ibus ibus-uniemoji

# =============================================================================
# Meta targets
# =============================================================================
.PHONY: dev
dev: cli python node go-tools rust-tools editors shell

.PHONY: desktop
desktop: wm desktop-apps fonts input-method security

.PHONY: all
all: dev desktop backup dotfiles

# =============================================================================
# Maintenance
# =============================================================================
.PHONY: clean
clean:
	@echo "cleaning package manager caches..."
	@cargo cache -a 2>/dev/null || true
	@sudo apt-get clean && sudo apt-get autoremove -y
	@uv cache clean 2>/dev/null || true
	@npm cache clean --force 2>/dev/null || true
	@go clean -cache 2>/dev/null || true

.PHONY: update
update:
	@echo "updating package lists..."
	@sudo apt-get update
	@echo "done. Run 'make all' to upgrade everything."

.PHONY: help
help:
	@echo "Usage:"
	@echo "  make all           Install everything"
	@echo "  make dev           Install dev tools"
	@echo "  make desktop       Install desktop apps"
	@echo "  make cli           Install CLI tools"
	@echo "  make python        Install Python tools"
	@echo "  make shell         Install fish + plugins"
	@echo "  make fonts         Install fonts"
	@echo "  make wm            Install window manager stack"
	@echo "  make editors       Install Neovim"
	@echo "  make backup        Install backup tools"
	@echo "  make security      Install security tools"
	@echo "  make dotfiles      Initialize dotfiles with chezmoi"
	@echo "  make clean         Clean all package manager caches"
	@echo "  make update        Update apt package lists"
	@echo "  make <package>     Install a single package"
	@echo "  ./hm.sh            Interactive fuzzy installer"
