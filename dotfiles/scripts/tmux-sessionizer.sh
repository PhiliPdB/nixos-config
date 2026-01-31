#! /usr/bin/env bash
# Requirements: tmux, fzf
# Modified from: https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

# Try to source user config
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/tmux-sessionizer"
if [ -f "$CONFIG_DIR/config" ]; then
    source "$CONFIG_DIR/config"
else # Setup default config
    export TMS_DIRS=(
        "$HOME/repositories"
    )
fi

## Helper functions

switch_to() {
    if [[ -z $TMUX ]]; then
        tmux attach-session -t "$1"
    else
        tmux switch-client -t "$1"
    fi
}

is_tmux_running() {
    tmux_running=$(pgrep tmux)

    if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        return 1
    else
        return 0
    fi
}

find_dirs() {
    for entry in "${TMS_DIRS[@]}"; do
        # Parse depth and path
        # If path is like "2:/path/to/dir", set depth to 2
        if [[ "$entry" =~ ^([0-9]+):(.+)$ ]]; then
            depth="${BASH_REMATCH[1]}"
            path="${BASH_REMATCH[2]}"
        else
            depth=1
            path="$entry"
        fi
        # Set min depth as to work with 0 depth (which means only the given directory)
        min_depth=$(( depth < 1 ? depth : 1 ))

        [[ -d "$path" ]] && find "$path" -mindepth "$min_depth" -maxdepth "$depth" -type d ! -name ".*"
    done
}

## Sessionizer

# Get selected either from the argument or fzf
if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find_dirs | fzf)
fi

# Check if selected is not empty
if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)

# If not in tmux, create and attach to new session
if ! is_tmux_running; then
    tmux new-session -ds "$selected_name" -c "$selected"
fi

# Else create detached session (if it does not exist)
if ! tmux has-session -t="$selected_name" 2> /dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected"
fi

# Switch to the selected session
switch_to "$selected_name"

