with import <nixpkgs> {}; [
vim gh neovim zsh tmux stow
# keyd
#   - needs source cloning - https://github.com/rvaiya/keyd?tab=readme-ov-file#from-source
#   - needs systemctl cmds for installation with config manual linking
#
# alacritty - cargo install with apt dept
#   - https://github.com/alacritty/alacritty/blob/master/INSTALL.md#dependencies
#   - then manually change default terminal
neofetch rofi


/*
TODO:
setup tmux /
setup i3 touchpad issues
    - scroll natural /
    - click /
setup default apps /
install npm node / - to install without npm first - https://github.com/tj/n?tab=readme-ov-file#installation
    - go - https://go.dev/doc/install
    - docker k8s
rofi config /
*/

ripgrep
prettierd
lazygit
zathura

# fzf - need apt in debian
gf
watchexec

zoxide

ps_mem

# i3 i3lock i3status
#   - installed by apt
maim xclip xdotool
blueman

# apps
google-chrome chromium brave slack
# zoom-us # need page download - https://zoom.us/download
#               - warning: wont install correctly needs manual installation of dependency
# clickup # not downloading in nix --too unstable
vscode-fhs zed-editor
# audacity pavucontrol - both needs to be installed from apt

# tools
less jq ffmpeg speedtest-cli ncdu unzip wget zip mpv font-manager
htop btop nethogs
qdirstat

# docker
#   - requires adding custom apt repo - https://docs.docker.com/engine/install/debian/#install-using-the-repository
 # kubectl - binary installation - https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux
# minikube - binary installation - https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fdebian+package
 jekyll bundler
# postgres - need to download from apt
# soda - all three from go - https://gobuffalo.io/documentation/database/soda/
# hydra - https://www.ory.sh/docs/hydra/5min-tutorial
# kratos - https://go-kratos.dev/en/docs/getting-started/start/
]
