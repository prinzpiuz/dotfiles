set fish_greeting ""
source $HOME/.config/fish/conf.d/abbr.fish
source $HOME/.config/fish/conf.d/env.fish
source $HOME/.config/fish/functions/my_functions.fish

if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end

auto_alias_project_directories
fish_vi_key_bindings
