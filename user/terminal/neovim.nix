{
  config,
  pkgs,
  ...
}:
let
  neovimConfigDir = "${config.home.homeDirectory}/nixos-config/dotfiles/nvim";
in
{
  # Disable stylix
  stylix.targets.neovim.enable = false;

  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      # General tools
      fd
      fzf
      ripgrep
      tree-sitter
      # Required for compilation
      cmake
      gcc
      gnumake
      # For lazy.nvim
      lua51Packages.lua
      lua51Packages.luarocks
      # Spell checking
      ltex-ls-plus
      # Others
      nodejs
      python3
    ];
  };

  # Set Neovim as the default editor
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Symlink config dir, but out of store so changes apply directly
  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink neovimConfigDir;
  };
}
