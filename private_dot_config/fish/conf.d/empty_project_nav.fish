# Project navigation helpers

# Activate a virtualenv if one exists in the given directory (default: cwd).
function auto_activate_venv
    set -l dir (pwd)
    test -n "$argv[1]"; and set dir $argv[1]

    if test -f "$dir/.venv/bin/activate.fish"
        source "$dir/.venv/bin/activate.fish"
    end
    return 0
end


# Claude Code only reads CLAUDE.md, not AGENTS.md. If a project has an
# AGENTS.md and no CLAUDE.md, drop in a one-line import so both agents
# see the same project instructions.
function ensure_claude_md
    set -l dir (pwd)
    test -n "$argv[1]"; and set dir $argv[1]

    # Nothing to bridge if the project has no AGENTS.md.
    test -f "$dir/AGENTS.md"; or return 0

    # Already bridged, in either supported location.
    if test -e "$dir/CLAUDE.md"; or test -e "$dir/.claude/CLAUDE.md"
        return 0
    end

    printf '@AGENTS.md\n' >"$dir/CLAUDE.md"

    # Keep it untracked without editing the repo's shared .gitignore.
    set -l git_dir (git -C "$dir" rev-parse --absolute-git-dir 2>/dev/null)
    if test -n "$git_dir"
        set -l exclude "$git_dir/info/exclude"
        mkdir -p (dirname "$exclude")
        if not test -e "$exclude"; or not grep -qxF 'CLAUDE.md' "$exclude"
            printf 'CLAUDE.md\n' >>"$exclude"
        end
    end

    echo "created CLAUDE.md (-> AGENTS.md) in $dir"
    return 0
end


# Single entry point for the project abbreviations.
function project_cd --argument-names dir
    cd "$dir"; or return 1
    auto_activate_venv
    ensure_claude_md
    return 0
end


# Auto-alias project directories
function auto_alias_project_directories
    set -l repos "hobby" "work/Nuventure" "Kodnkin"

    for repo in $repos
        set -l repo_path ~/projects/$repo

        if test -d $repo_path
            for subrepo in (find $repo_path -maxdepth 1 -mindepth 1 -type d -printf '%f\n')
                abbr -a $subrepo "project_cd $repo_path/$subrepo"
            end
        end
    end
end
