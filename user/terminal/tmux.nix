{ pkgs, ... }:
{
  stylix.targets.tmux.enable = false;

  # Install tmux sessionizer
  home.packages = with pkgs; [
    tmux-sessionizer
  ];

  # Tmux setup
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    clock24 = true;
    newSession = true;

    keyMode = "vi";
    mouse = true;
    focusEvents = true;

    baseIndex = 1;
    shortcut = "a";

    plugins = with pkgs; [
      unstable.tmuxPlugins.vim-tmux-navigator
    ];

    extraConfig = ''
      # Reload Tmux config
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

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
      bind s display-popup -w 80% -h 60% -E "tms switch"
      bind C-r "run-shell 'tms refresh'"

      # Quick shortcuts
      bind C-1 "run-shell 'tms marks open 0'"
      bind C-2 "run-shell 'tms marks open 1'"
      bind C-3 "run-shell 'tms marks open 2'"
      bind C-4 "run-shell 'tms marks open 3'"


      ### Window selection and resizing bindings

      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R

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
      # Reduce escape time for neovim
      set-option -sg escape-time 10
    '';
  };
}
