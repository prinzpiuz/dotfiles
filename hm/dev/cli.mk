# dev/cli.mk — CLI tools and utilities

# APT packages
APT += ripgrep jq bat fzf htop maim fish copyq inotify-tools tldr
APT += git git-extras
APT += restic ledger hledger
APT += sshfs

# Package name overrides (apt name differs from target name)
PKG_bat := bat
PKG_fd  := fd-find

# Cargo packages
CARGO += eza zoxide fd tree-sitter-cli stylua
