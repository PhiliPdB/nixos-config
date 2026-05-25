{
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  cfg = config.cfg.desktop;
in
{
  config = lib.mkIf (cfg.enable && cfg.manager == "plasma") {
    # Enable plasma-login-manager
    services.displayManager.plasma-login-manager.enable = true;
    # Enable the KDE Plasma Desktop Environment.
    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = with pkgs; [
      # Install icon theme
      papirus-icon-theme
      # Clipboard
      wl-clipboard
    ];

    ## Plasma login manager configuration

    # Set wallpaper
    environment.etc."plasmalogin.conf".text = ''
      [Greeter][Wallpaper][org.kde.image][General]
      Image=file://${user.wallpaper.lockscreen}
    '';

    # Set user profile icon
    systemd.tmpfiles.rules = [
      "L /var/lib/AccountsService/icons/${user.username} - - - - ${user.profileImage}"
    ];
  };
}
