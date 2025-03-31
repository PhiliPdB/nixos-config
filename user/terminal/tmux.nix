{ pkgs, ... }: {
  programs.tmux =
    let
      tokyo-night-tmux = pkgs.tmuxPlugins.mkTmuxPlugin {
        pluginName = "tokyo_night";
        rtpFilePath = "tokyo-night.tmux";

        version = "v1.6.6";
        src = pkgs.fetchFromGitHub {
          owner = "janoamaral";
          repo = "tokyo-night-tmux";
          rev = "v1.6.6";
          sha256 = "sha256-TOS9+eOEMInAgosB3D9KhahudW2i1ZEH+IXEc0RCpU0=";
        };
      };
    in
    {
      enable = true;
      terminal = "xterm-256color";
      clock24 = true;

      keyMode = "vi";
      mouse = true;

      baseIndex = 1;
      shortcut = "Space";

      sensibleOnTop = true;
      plugins = with pkgs; [
        {
          plugin = tokyo-night-tmux;
          extraConfig = ''
            set -g @tokyo-night-tmux_show_datetime 0
            set -g @tokyo-night-tmux_window_id_style none
          '';
        }
      ];

      extraConfig = ''
        # Vim style pane selection
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        ### Arrow keys for pane selection

        # Use Alt-arrow keys without prefix key to switch panes
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # Shift arrow to switch windows
        bind -n S-Left  previous-window
        bind -n S-Right next-window

        # Shift Alt vim keys to switch windows
        bind -n M-H previous-window
        bind -n M-L next-window

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
      '';
    };
}
