{ pkgs, inputs, ... }:
let
  dotfilesDir = inputs.self.outputs.dotfiles.default;
in
{
  stylix.targets.tmux.enable = false;

  # Install tmux sessionizer
  home.packages = with pkgs; [
    (writeScriptBin "tms" (builtins.readFile (dotfilesDir + /scripts/tmux-sessionizer.sh)))
  ];

  # Tmux setup
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    clock24 = true;

    keyMode = "vi";
    mouse = true;
    focusEvents = true;

    baseIndex = 1;
    shortcut = "a";

    extraConfig = ''
      # Reload Tmux config
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      ### General behaviour

      set -g detach-on-destroy off

      ### Status bar config

      set -g status-position top
      set -g status-justify absolute-centre
      set -g status-style "bg=#30363f"
      set -g window-status-current-style "fg=#4fa6ed bold"
      set -g status-left "#S"
      set -g status-left-length 40
      set -g status-right ""

      ### Tmux sessionizer

      # Open new project
      bind o display-popup -w 80% -h 60% -E "tms"

      # Quick shortcuts
      bind C-1 "run-shell 'tms ~/nixos-config"
      # TODO: Add more shortcuts?!

      ### Window selection and resizing bindings

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      ### Other key bindings

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Split panes and open new windows at the current path
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # More intuitive pane splitting
      bind | split-window -h
      bind - split-window -v

      # Set true color support
      set-option -a terminal-features 'xterm-256color:RGB'
      # Reduce escape time for neovim and vi-mode
      set-option -sg escape-time 0
    '';
  };
}
