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



#kill process by port
function pk
    if test -z "$argv[1]"
        echo "Usage: kill_process_by_port <port>"
    else 
        fuser -k "$argv[1]/tcp"
    end
end
