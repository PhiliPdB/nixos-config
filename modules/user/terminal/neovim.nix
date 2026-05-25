{
  config,
  pkgs,
  ...
}:
let
  neovimConfigDir = "${config.home.homeDirectory}/repositories/nvim-config";
in
{
  # Disable stylix
  stylix.targets.neovim.enable = false;

  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;

    withRuby = false;
    withPython3 = true;

    # init.lua is managed imperatively, from my nvim-config repo.
    sideloadInitLua = true;

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
      # Others
      nodejs
      python3

      # General nice-to-have lsps
      bash-language-server
      # Spell checking
      ltex-ls-plus
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
