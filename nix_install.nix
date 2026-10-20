# Package list for the user nix profile.
#
# NOT a nix expression - a reference of what is installed via `nix profile`.
# Everything here came from the `nixpkgs` registry flake, so
# `nix profile upgrade --all` works against all of it.
#
#   install all (pi comes from its own flake, so exclude it here):
#     NIXPKGS_ALLOW_UNFREE=1 nix profile install --impure \
#       $(nix eval --json -f nix_install.nix | jq -r '.[]|select(. != "pi")|"nixpkgs#\(.)"' \
#         | tr '\n' ' ')
#
#   upgrade all:
#     nix profile upgrade --all
#
# NIXPKGS_ALLOW_UNFREE is only needed for slack and discord. There is no
# ~/.config/nixpkgs/config.nix on this machine, so unfree has to be granted
# per invocation.
#
# The previous revision of this file used `nix-env` and `import <nixpkgs>`.
# That mechanism is gone: `nix-env` now refuses this profile outright.
# See git log for the old version.

let
  # shells, editors, viewers
  core = [
    "zsh"
    "vim"
    "neovim"
    "helix" # binary is `hx`
    "less"
    "bat"
  ];

  vcs = [
    "git"
    "gh"
    "lazygit"
    "difftastic"
    "abduco"
  ];

  searchAndNav = [
    "ripgrep" # binary is `rg`
    "fzf"
    "zoxide"
    "ueberzugpp"
    "yazi"
  ];

  terminalAndTui = [
    "kitty"
    "sqlitebrowser"
  ];

  sysutils = [
    "htop"
    "btop"
    "ncdu"
    "qdirstat"
    "ps_mem"
    "nethogs"
    "watchexec"
    "valgrind"
  ];

  filesAndMedia = [
    "wget"
    "unzip"
    "zip"
    "ffmpeg"
    "w3m"
    "dillo"
    "netsurf-browser" # binary is `netsurf-gtk3`
  ];

  mail = [
    "neomutt" # priority 5 - wins file collisions
    "mutt" # priority 4 - see note below
    "miniflux"
  ];

  langs = [
    "nushell"
    "stylua"
    "tree-sitter"
    "bundler"
    "jekyll"
  ];

  systemAndDesktop = [
    "stow"
    "direnv"
    "xdotool"
    "maim"
    "rofi"
    "font-manager"
    "blueman"
    "keyd"
    "normcap"
    "raylib"
  ];

  apps = [
    "brave"
    "vscodium" # binary is `codium`
    "zathura"
    "jq"
    "dissent"
    "webcord"
    "simplescreenrecorder"
    "teams-for-linux"
    "thunderbird-bin"
    "tmatrix"
    "tmux"
    "speedtest-cli"
    "gf" # binary is `gf2`
  ];

  # not from nixpkgs - kept separate so the nixpkgs# loop above stays valid
  otherFlakes = [
    "pi" # github:earendil-works/pi/stable
  ];

  # unfree - needs NIXPKGS_ALLOW_UNFREE=1
  unfree = [
    "slack"
    "discord"
  ];
in
  builtins.concatLists [
    core
    vcs
    searchAndNav
    terminalAndTui
    sysutils
    filesAndMedia
    mail
    langs
    systemAndDesktop
    apps
    unfree
    otherFlakes
  ]
# NOTES
#
# mutt vs neomutt
#   Both ship bin/smime_keys and collide in the profile. mutt is installed at
#   priority 4 and neomutt at 5, so neomutt owns the shared file.
#   To re-create that from scratch:
#     nix profile install nixpkgs#neomutt
#     nix profile install --priority 4 nixpkgs#mutt
#
# upstream renames vs the 2024 nix-env set
#   helix            -> hx
#   vscodium         -> codium
#   netsurf          -> netsurf-browser, binary netsurf-gtk3
#   gf               -> gf, binary gf2
#   neofetch         -> removed upstream, dropped (hyfetch/fastfetch exist)
#   python3.11-speedtest-cli -> speedtest-cli
#   zathura-with-plugins -> zathura (still resolves to a with-plugins build)
#
# from the old file, deliberately not listed
#   prettierd, zed-editor, mpv - were commented out or absent from the profile
#   alacritty, ghostty, wezterm - cargo/other installers, not nixpkgs here
#   i3, i3lock, i3status, pavucontrol, audacity, vlc, xclip - apt, not nix
