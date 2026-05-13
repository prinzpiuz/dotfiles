#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Targets to exclude from the interactive list (groups and meta targets)
exclude_patterns() {
    cat <<'EOF'
all
dev
desktop
cli
python
node
go-tools
rust-tools
shell
fonts
wm
desktop-apps
security
backup
editors
vpn
input-method
clean
update
help
dotfiles
EOF
}

# Discover all targets from the Makefile
packages() {
    make -pn -C "$SCRIPT_DIR" 2>/dev/null |
        grep -E '^[a-zA-Z][a-zA-Z0-9_-]*:' |
        sed 's/:.*//' |
        grep -vxF -f <(exclude_patterns) |
        sort -u
}

# Check if fzf is available
if ! command -v fzf &>/dev/null; then
    echo "fzf is required. Install it with: sudo apt install fzf"
    exit 1
fi

echo "System Setup — Interactive Installer"
echo "Tab to select multiple, Enter to install, Esc to quit"
echo ""

while true; do
    selected=$(
        packages | fzf \
            --multi \
            --prompt "install > " \
            --header "Tab=select multiple | Enter=install | Esc=quit" \
            --preview "make -n -C '$SCRIPT_DIR' {} 2>/dev/null" \
            --preview-window "right:50%:wrap"
    ) || break

    if [ -n "$selected" ]; then
        echo ""
        echo "Installing: $selected"
        echo "---"
        for pkg in $selected; do
            make -C "$SCRIPT_DIR" "$pkg"
        done
        echo ""
        echo "Done. Press Enter to continue or Esc to quit."
        read -r
    fi
done
