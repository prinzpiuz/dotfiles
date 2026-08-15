function view_csv_pretty 
    if [ -z "$1" ]
        echo "Usage: view_csv_pretty <file.csv>"
    end
    cat "$1" | column -s, -t | less -F -S -X -K
end

function recently_modified 
    set recent_file $(ls -t | head -n1)
    echo "Most recently modified file: $recent_file"
end

function compress_files
  if test -z "$argv[1]"
    echo "Usage: compress_files <archive_name.zip> <file1> <file2> ..."
  else
    zip -r "$argv[1]" $argv[2..-1]
  end
end


function process_with_most_memory
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head
end



function find_listening_ports
    if test -z "$argv[1]"
        echo "Usage: find_listening_ports <pid>"
    else 
        ss -tulnp | grep "$argv[1]"
    end
end

function edit_and_apply 
    if test -z "$argv[1]"
        echo "Usage: Need File Name"
    else 
        chezmoi edit "$argv[1]" && chezmoi apply "$argv[1]"
    end
end


#activate virtual environment if exists in the current directory
function auto_activate_venv
    if test -f ".venv/bin/activate.fish"
        source ".venv/bin/activate.fish"
    end
end


# Auto-alias project directories
function auto_alias_project_directories
    set repos "hobby" "work/Nuventure" "Kodnkin"

    for repo in $repos
        set repo_path ~/projects/$repo
        
        if test -d $repo_path
            for subrepo in (find $repo_path -maxdepth 1 -mindepth 1 -type d -printf '%f\n')
                abbr -a $subrepo "cd $repo_path/$subrepo && auto_activate_venv"
            end
        end
    end
end

#kill process by port
function pk
    if test -z "$argv[1]"
        echo "Usage: kill_process_by_port <port>"
    else 
        fuser -k "$argv[1]/tcp"
    end
end

# Restore last session for the current directory
function vs
    nvim -c "lua require('persistence').load()"
end

# Restore the very last session regardless of directory
function vl
    nvim -c "lua require('persistence').load({ last = true })"
end
