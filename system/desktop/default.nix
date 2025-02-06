{ pkgs, config, lib, user, ... }:
{
  imports = [
    ./plasma.nix
  ];

  options = {
    desktop-environment.enable = lib.mkEnableOption "enable a desktop environment";
  };

  config = lib.mkIf config.desktop-environment.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable kde plasma by default
    kde-plasma.enable = lib.mkDefault (user.desktop == "plasma");

    # Setup sddm
    services.displayManager.sddm = {
      enable = true;
      # TODO: Theme?
    };

    environment.systemPackages = [
      # Set background of the breeze theme
      (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
        [General]
        background=${user.wallpaper}
      '')
      # Set user profile icon
      (pkgs.runCommand "user-icons" {} ''
        mkdir -p $out/share/sddm/faces
        ln -s ${user.profileImage} $out/share/sddm/faces/${user.username}.face.icon
      '')
    ];
  };
}