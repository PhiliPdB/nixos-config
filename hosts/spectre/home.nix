{
  inputs,
  user,
  pkgs,
  ...
}:

{
  imports = [
    inputs.self.outputs.homeModules.default
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = user.username;
  home.homeDirectory = "/home/${user.username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Setup programs
  cfg.programs = {
    office.enable = true;
    proton.enable = true;
  };

  # Set plasma options
  cfg.plasma = {
    pinnedItems = [
      "preferred://filemanager"
      "preferred://browser"
    ];
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Chat apps
    # unstable.element-desktop
    # unstable.signal-desktop

    # Uncategorized
    vlc
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
