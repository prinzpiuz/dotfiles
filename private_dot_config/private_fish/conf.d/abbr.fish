#flutter & android
abbr sdkmanager '/usr/lib/Android/cmdline-tools/latest/bin/sdkmanager'
abbr android 'flutter emulator --launch pixel'
abbr adb 'platform-tools/adb'

#blutooth
abbr bt 'bluetoothctl power on && bluetoothctl connect 80:C3:BA:4F:A9:94'
abbr bt_off 'bluetoothctl power off'

#postgresql
abbr pg_start 'systemctl start postgresql'
abbr pg_restart 'systemctl restart postgresql'
abbr pg_stop 'systemctl stop postgresql'
abbr pg_admin 'sudo su - postgres'

#mysql
abbr mstart 'systemctl start mysql'
abbr mstop 'systemctl stop mysql'
abbr mstatus 'systemctl status mysql'
abbr mrestart 'systemctl restart mysql'

#redis
abbr rstart 'systemctl start redis-server'
abbr rstop 'systemctl stop redis-server'
abbr rstatus 'systemctl status redis-server'
abbr rrestart 'systemctl restart redis-server'

#debian
abbr update 'sudo apt update && sudo apt upgrade -y'
abbr clean 'sudo apt autoremove && sudo apt autoclean'
abbr install 'sudo apt install'
abbr remove 'sudo apt remove'
abbr search 'apt search'

#general & linux
abbr p 'ping -i 1 -c 5 -w 30 -q 8.8.8.8'
abbr nd 'sudo chattr +i'
abbr un 'sudo chattr -i'
# abbr ll 'eza --long --all  --header --git --icons --color=always --group-directories-first'
abbr list_with_size 'eza --long --all  --header --git --icons --total-size --color=always --group-directories-first'

#kitty
abbr pic 'kitty +kitten icat'
abbr s 'kitty +kitten ssh'
abbr d 'kitty +kitten diff'
abbr themes 'kitty +kitten themes'
abbr update_kitty 'curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin'

#vpn
abbr vpn_session 'openvpn3 sessions-list | grep Path | awk '{ print \$2 }''
abbr vpn_disconnect 'openvpn3 session-manage --disconnect --session-path'
abbr ms 'mullvad status'
abbr mc 'mullvad connect'
abbr md 'mullvad disconnect'

#fish
abbr reload 'source ~/.config/fish/config.fish'
abbr tc 'tide configure'

#git
abbr gca 'git commit --amend -m'
abbr pcr 'pre-commit run --all-files'

#ledger
abbr balance 'ledger -f $LEDGER balance'
abbr ledger_summary 'paisa serve --config $PAISA_CONFIG'

#python
abbr run 'python manage.py runserver || flutter run'
abbr Ipython3 'python3 -m IPython'

#restic
set RESTIC_BASE_COMMAND "restic --verbose --repo /media/prinzpiuz/backups/Personal --password-file ~/.config/resticprofile/password.txt"
set DELETE_UNWANTED_FILES sudo "rm -rf /tmp/resticprofile-profile-src.lock && rm -rf /home/prinzpiuz/.config/resticprofile/log/*"
set RESTICPROFILE_BASE_COMMAND "sudo resticprofile --config /home/prinzpiuz/.config/resticprofile/profiles.conf --name 'default'"
alias restic_repo_unlock="$RESTIC_BASE_COMMAND unlock"
alias restic_repo_ls="$RESTIC_BASE_COMMAND snapshots"
alias restic_list="$RESTIC_BASE_COMMAND list"
alias restic_stats="$RESTIC_BASE_COMMAND stats"
alias rp_dry_run="$DELETE_UNWANTED_FILES || $RESTICPROFILE_BASE_COMMAND backup --dry-run"
alias rp_run="$RESTICPROFILE_BASE_COMMAND backup"
alias rp_schedule="restic_repo_unlock && $DELETE_UNWANTED_FILES || $RESTICPROFILE_BASE_COMMAND schedule"
alias rp_remove_schedule="restic_repo_unlock && $DELETE_UNWANTED_FILES || $RESTICPROFILE_BASE_COMMAND unschedule"
alias rp_schedule_status="$RESTICPROFILE_BASE_COMMAND status"


#uv
abbr uvr 'uv tool run' #run command in temporary environment
abbr uvi 'uv tool install' 
abbr uvu 'uv tool uninstall' 
abbr uvl 'uv tool list'
abbr uvus 'uv tool update-shell' # update shell
