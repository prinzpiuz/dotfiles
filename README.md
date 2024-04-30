# My DotFiles

This Dotfiles are managed with [chezmoi](https://chezmoi.io/)

Wiki related to system configuration can be seen [here](https://github.com/prinzpiuz/dotfiles/wiki/System%E2%80%90configuration)

The dotfiles and configurations in the default branch are for my primary machine, which is [Debian](https://www.debian.org/)-based. I have been using this for more than 10 years, and it has proven to be super stable.

To re-use this repo, run the following commands:

    chezmoi init prinzpiuz

    chezmoi diff #to check the changes with your current files

    chezmoi apply -v #apply the changes if you are okay

For a full list of commands run:
  
    chezmoi help
