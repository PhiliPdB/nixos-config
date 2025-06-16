{ lib, ... }: {
  imports = [
    ./bat.nix
    ./fzf.nix
    ./tmux.nix
    ./zsh.nix
  ];

  zsh.enable = lib.mkDefault true;

  # Install lsd as an ls alternative
  programs.lsd = {
    enable = true;
    # Don't enable integration
    enableBashIntegration = false;
    enableZshIntegration = false;
    enableFishIntegration = false;
  };

  # Set default shell aliases
  home.shellAliases = {
      ls = "lsd";
      ll = "ls -lF";
      la = "ls -A";
      lla = "ls -alF";

      cat = "bat";

      venv = "source ./venv/bin/activate";
  };

  # Enable zoxide
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };
}
