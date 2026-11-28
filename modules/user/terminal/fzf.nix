{
  programs.fzf = {
    enable = true;

    tmux = {
      enableShellIntegration = true;
      shellIntegrationOptions = [
        "-p 80%,60%"
      ];
    };

    # Options for fzf file finder (on Ctrl+T)
    fileWidget.options = [
      "--walker-skip .git"
      "--preview 'bat --color=always --style=numbers --line-range=:500 {}"
      "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
    ];

    # Options for fzf directory switcher (on ALT+C)
    changeDirWidget.options = [
      "--walker-skip .git"
      "--preview 'lsd --tree {}'"
    ];
  };
}
