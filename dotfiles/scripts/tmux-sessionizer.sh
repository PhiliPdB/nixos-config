#! /usr/bin/env bash
# Requirements: tmux, fzf
# Modified from: https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

# TODO: Maybe read from some config file?!
DIRS=(
    "$HOME"
    "$HOME/repositories"
    "$HOME/repositories/university"
)

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

## Sessionizer

# Get selected either from the argument or fzf
if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(\
        find "${DIRS[@]}" -mindepth 1 -maxdepth 1 -type d ! -name ".*" \
        | fzf \
    )
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
if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected"
fi

# Switch to the selected session
switch_to "$selected_name"

