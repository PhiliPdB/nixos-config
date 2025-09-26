{ pkgs, inputs, ... }:
let
  dotfilesDir = inputs.self.outputs.dotfiles.default;
in
{
  # Install Neovim
  home.packages = with pkgs; [
    neovim
  ];

  # Set Neovim as the default editor
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Setup shell aliases
  home.shellAliases = {
    vim = "nvim";
    vimdiff = "nvim -d";
  };
}
