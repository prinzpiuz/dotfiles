#!/usr/bin/env bash
#
# Set up shared agent configuration for Claude Code and Codex.
#
#   ~/.agents/AGENTS.md   shared instructions (source of truth)
#   ~/.agents/skills/     shared Agent Skills
#
# Codex reads AGENTS.md natively; Claude Code only reads CLAUDE.md, so it
# gets symlinks. Safe to re-run: correct links are left alone, real files
# are backed up before being replaced.
#
# Usage:
#   ./setup-agents.sh            link config, bridge project repos
#   ./setup-agents.sh --dry-run  show what would change, touch nothing
#   ./setup-agents.sh --no-projects   skip the repo bridging pass

set -euo pipefail

AGENTS_HOME="${AGENTS_HOME:-$HOME/.agents}"
PROJECT_ROOTS=(
    "$HOME/projects/hobby"
    "$HOME/projects/work/Nuventure"
    "$HOME/projects/Kodnkin"
)

DRY_RUN=0
DO_PROJECTS=1
STAMP="$(date +%Y%m%d-%H%M%S)"
CHANGES=0

for arg in "$@"; do
    case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --no-projects) DO_PROJECTS=0 ;;
    -h | --help)
        sed -n '2,20p' "$0"
        exit 0
        ;;
    *)
        echo "unknown option: $arg" >&2
        exit 2
        ;;
    esac
done

run() {
    if [[ $DRY_RUN -eq 1 ]]; then
        echo "  would: $*"
    else
        "$@"
    fi
    CHANGES=$((CHANGES + 1))
}

# link <target> <link_path>
link() {
    local target="$1" link_path="$2"

    if [[ ! -e "$target" ]]; then
        echo "skip $link_path: target $target does not exist" >&2
        return 0
    fi

    if [[ -L "$link_path" ]]; then
        if [[ "$(readlink -f "$link_path")" == "$(readlink -f "$target")" ]]; then
            echo "ok   $link_path"
            return 0
        fi
        echo "relink $link_path (was -> $(readlink "$link_path"))"
        run rm "$link_path"
    elif [[ -e "$link_path" ]]; then
        echo "backup $link_path -> $link_path.$STAMP"
        run mv "$link_path" "$link_path.$STAMP"
    else
        echo "link $link_path -> $target"
    fi

    run mkdir -p "$(dirname "$link_path")"
    run ln -s "$target" "$link_path"
}

# Give a repo with AGENTS.md a CLAUDE.md that imports it.
bridge_repo() {
    local dir="$1"

    [[ -f "$dir/AGENTS.md" ]] || return 0
    [[ -e "$dir/CLAUDE.md" || -e "$dir/.claude/CLAUDE.md" ]] && return 0

    echo "bridge $dir/CLAUDE.md"
    if [[ $DRY_RUN -eq 0 ]]; then
        printf '@AGENTS.md\n' >"$dir/CLAUDE.md"

        local git_dir exclude
        if git_dir="$(git -C "$dir" rev-parse --absolute-git-dir 2>/dev/null)"; then
            exclude="$git_dir/info/exclude"
            mkdir -p "$(dirname "$exclude")"
            grep -qxF 'CLAUDE.md' "$exclude" 2>/dev/null ||
                printf 'CLAUDE.md\n' >>"$exclude"
        fi
    fi
    CHANGES=$((CHANGES + 1))
}

echo "== shared agent config =="

if [[ ! -d "$AGENTS_HOME" ]]; then
    echo "create $AGENTS_HOME"
    run mkdir -p "$AGENTS_HOME/skills"
fi

if [[ ! -f "$AGENTS_HOME/AGENTS.md" && $DRY_RUN -eq 0 ]]; then
    echo "warning: $AGENTS_HOME/AGENTS.md is missing." >&2
    echo "         Restore it from your dotfiles before relying on this setup." >&2
fi

# Claude Code: no AGENTS.md support, so both paths are symlinked.
link "$AGENTS_HOME/AGENTS.md" "$HOME/.claude/CLAUDE.md"
link "$AGENTS_HOME/skills" "$HOME/.claude/skills"

# Codex: reads AGENTS.md and ~/.agents/skills natively; only the global
# instruction file needs pointing at the shared copy.
link "$AGENTS_HOME/AGENTS.md" "$HOME/.codex/AGENTS.md"

if [[ $DO_PROJECTS -eq 1 ]]; then
    echo
    echo "== project repos =="
    for root in "${PROJECT_ROOTS[@]}"; do
        [[ -d "$root" ]] || continue
        while IFS= read -r -d '' dir; do
            bridge_repo "$dir"
        done < <(find "$root" -maxdepth 1 -mindepth 1 -type d -print0)
    done
fi

echo
if [[ $DRY_RUN -eq 1 ]]; then
    echo "dry run: $CHANGES change(s) would be made"
else
    echo "done: $CHANGES change(s)"
    echo "verify with:  claude  ->  /memory"
fi
