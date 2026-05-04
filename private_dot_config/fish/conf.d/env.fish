#bins
fish_add_path ~/.local/bin
fish_add_path $HOME/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/go/bin

#android & flutter
set --universal --export ANDROID_HOME /usr/lib/Android
set --universal --export ANDROID_SDK_ROOT /usr/lib/Android
set --universal --export FLUTTER_HOME /usr/local/bin/flutter
set --universal --export CHROME_EXECUTABLE /usr/bin/google-chrome-stable
set --universal --export GRADLE_HOME /opt/gradle/gradle-7.5.1
set --universal --export JAVA_HOME (dirname (dirname (readlink -f (which java))))    
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path $ANDROID_SDK_ROOT
fish_add_path $FLUTTER_HOME/bin
fish_add_path $GRADLE_HOME/bin
fish_add_path $JAVA_HOME
fish_add_path $ANDROID_SDK_ROOT/cmdline-tools/latest/bin



#go
set -x -U GOPATH $HOME/go
set -x GOROOT  /usr/local/go
set -x PATH $PATH $GOROOT/bin
fish_add_path $GOPATH/bin

#ibus
set --universal --export GTK_IM_MODULE ibus
set --universal --export QT_IM_MODULE ibus
set --universal --export XMODIFIERS @im=ibus
set --universal --export GLFW_IM_MODULE "ibus"

#volta
set --universal --export VOLTA_HOME "$HOME/.volta"
fish_add_path $VOLTA_HOME/bin

#python
set --universal --export PYENV_ROOT "$HOME/.pyenv"
set --universal --export PYENV_ROOT "$HOME/.pyenv"

#code
set --universal --export EDITOR "code --wait"

# #general
set --universal --export XDG_RUNTIME_DIR "/run/user/$UID"
set --universal --export DBUS_SESSION_BUS_ADDRESS "unix:path=$XDG_RUNTIME_DIR/bus"

#ledger
set --universal --export PAISA_CONFIG "$HOME/prinzpiuz-notes/prinzpiuz-notes/Notes/Finance/paisa/paisa.yaml"
set --universal --export LEDGER "$HOME/prinzpiuz-notes/prinzpiuz-notes/Notes/Finance/paisa/main.ledger"

#fzf
# Use fd instead of find for speed and to respect .gitignore
set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# Set colors to match your Kitty/i3 theme (optional)
set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

# This makes fzf show a nice eza tree view when you highlight a directory
set -gx FZF_ALT_C_OPTS "--preview 'eza --tree --color=always {} | head -200'"

# Enable previews using 'bat'
set -gx FZF_ENABLE_OPEN_PREVIEW 1
set -gx FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"


#vivid color scheme
set -gx LS_COLORS (vivid generate solarized-dark)
