. "$HOME/.cargo/env"

# Vite+ bin (https://viteplus.dev)
. "/home/tharun/.config/vite-plus/env"

# let nix ncurses find system terminfo (xterm-rex etc)
export TERMINFO_DIRS="$HOME/.terminfo:/usr/share/terminfo:/lib/terminfo${TERMINFO_DIRS:+:$TERMINFO_DIRS}"
