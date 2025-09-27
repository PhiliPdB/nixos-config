{ lib, pkgs, inputs, ... }:
let
  dotfilesDir = inputs.self.outputs.dotfiles.default;
  neovimConfigDir = dotfilesDir + "/nvim";

  packages = with pkgs; {
    tools = [
      fzf
      tree-sitter
    ];

    c = [
      cmake
      gcc
      gnumake
    ];

    luatools = [
      lua-language-server
      stylua
    ];
  };
in
{
  # TODO: Disable stylix?!
  stylix.targets.neovim.enable = false;

  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = lib.pipe packages [
      (lib.mapAttrsToList (name: value: value))
      lib.flatten
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
