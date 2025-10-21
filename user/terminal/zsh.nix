{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  dotfilesDir = inputs.self.outputs.dotfiles.default;
in
{
  options = {
    zsh.enable = lib.mkEnableOption "enable zsh";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history =
        let
          hist_size = 10000;
        in
        {
          size = hist_size;
          save = hist_size;
          append = true;
          share = true;

          saveNoDups = true;
          findNoDups = true;
          ignoreAllDups = true;
          ignoreDups = true;
          ignoreSpace = true;

          expireDuplicatesFirst = true;
        };

      plugins = [
        # Prompt + prompt setup
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = lib.cleanSource (dotfilesDir + /zsh);
          file = "p10k-config.zsh";
        }
        # Vi mode
        {
          name = "vi-mode";
          src = pkgs.unstable.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];

      initContent =
        let
          zvm_config = lib.mkOrder 500 ''
            ZVM_INIT_MODE=sourcing
            function zvm_config() {
              ZVM_SYSTEM_CLIPBOARD_ENABLED=true
              ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
            }
          '';
        in
        lib.mkMerge [ zvm_config ];

      oh-my-zsh = {
        enable = true;
        plugins = [
          "colored-man-pages"
          "gitignore"
        ];
      };
    };
  };
}
