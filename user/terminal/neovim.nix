{ lib, pkgs, inputs, ... }:
let
  dotfilesDir = inputs.self.outputs.dotfiles.default;
  neovimConfigDir = dotfilesDir + "/nvim";
in
{
  # TODO: Disable stylix?!
  stylix.targets.neovim.enable = false;

  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      # General tools
      fzf
      tree-sitter
      # Required for compilation
      cmake
      gcc
      gnumake
      # Others
      nodejs
    ];
  };

  # Set Neovim as the default editor
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # TODO: Figure out this symlink
  # xdg.configFile."nvim/lua" = {
  #   recursive = true;
  #   source = neovimConfigDir + "/lua";
  # };
}
