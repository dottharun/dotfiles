# my dotfiles managed via GNU stow

- first clone the at home like `~/dotfiles`
- just do `stow -v <appdir>` to view each app

1. TMUX
    - requires tpm to be installed -- (git cloning some repo --maybe wont work with nixos)

2. NVIM
    - requires ripgrep for telescope
    - vim-plug installation (manual) -- switch to lazynvim, it can bootstrap itself
    - javascript ecosystem formatting requires prettierd installation
    - lazygit
    - tex viewing requires - zathura pdf viewer

3. bin
    - requires fzf for tmux-sessionizer, and zsh bindings
    - misc:
        - gf2 from NixOS-search - better frontend for gdb
        - watchexec for command running

4. ZSH
    - and making it as default shell
    - zoxide installation manual

5. Ubuntu setup
    - keyd installed manually and symlinked manually since the config file in system dir not user dir
        - keyd must be installed and reloaded for this to work
    - laptop touchpad in configured manually since gnome ui settings breaks in i3
    - memory watching alias always requires `ps_mem` installed

6. i3
    - used brightness script in bin for brightness control
    - for screenshot need these tools
        maim
        xclip
        xdotool
    - not sure - maybe i need i3lock and i3status

7. TODO - research how to use android as webcam with OBS-studio

## basics
- vim, gh , neovim, zsh, tmux, stow, keyd, git

## common tools
- node, n- node version manager, npm, prettier
- go
- docker, kubernetes, minikube
- rust - to get cargo
