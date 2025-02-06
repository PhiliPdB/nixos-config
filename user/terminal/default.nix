{ pkgs, lib, ... }: {
  imports = [
    ./zsh.nix
  ];

  zsh.enable = lib.mkDefault true;

  # Install lsd as an ls alternative
  home.packages = [
    pkgs.lsd
  ];

  # Set default shell aliases
  home.shellAliases = {
      ls = "lsd";
      ll = "ls -lF";
      la = "ls -A";
      lla = "ls -alF";

      venv = "source ./venv/bin/activate";
  };

  # Enable fzf
  programs.fzf.enable = true;
}