{ lib, config, pkgs, ... }:
{
  options = {
    zsh.enable = lib.mkEnableOption "enable zsh";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = lib.cleanSource ../dotfiles;
          file = "p10k-config.zsh";
        }
      ];

      oh-my-zsh = {
        enable = true;
        plugins = [
          "cabal"
          "colored-man-pages"
          "colorize"
          "docker"
          "docker-compose"
          "git"
          "gitignore"
          "pyenv"
          "sudo"
          "wd"
        ];
      };
    };
  };
}
