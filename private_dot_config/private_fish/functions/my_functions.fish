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

#to auto alias projects in hobby dir
function auto_alias_project_directories 
    for repo in (find ~/projects/hobby -maxdepth 1 -type d -printf '%f\n')
        if test "$repo" != "." -a "$repo" != ".."
            alias $repo "cd ~/projects/hobby/$repo"
        end
    end
end

function activate_venv
  if test -z "$argv[1]"
    echo "Usage: activate_venv <venv_name>"
    return 1
  end
  set venv_name $argv[1]
  if test -d ~/venvs/$venv_name
    source ~/venvs/$venv_name/bin/activate.fish
    set -l old_venv $VIRTUAL_ENV
    set -gx VIRTUAL_ENV $venv_name
    if test -n $old_venv -a $old_venv != $VIRTUAL_ENV
      echo "Deactivated virtualenv '$old_venv'."
    end
    echo "Activated virtualenv '$venv_name'."
  else
    echo "Error: Virtual environment '$venv_name' not found in ~/venvs."
    return 1
  end
end

function auto_alias_virtual_envs
    for venv in (ls ~/venvs)
    alias "$venv""env" "source ~/venvs/$venv/bin/activate.fish ; set -l old_venv \$VIRTUAL_ENV ; set -gx VIRTUAL_ENV $venv ; if test -n \$old_venv ; and test \$old_venv != \$VIRTUAL_ENV ; echo \"Deactivated virtualenv '\$old_venv'.\" ; end ; echo \"Activated virtualenv '$venv'.\""
    end
end
