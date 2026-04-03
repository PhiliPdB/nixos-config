{ pkgs, config, lib, user, ... }:
let
  cfg = config.cfg.desktop;
in
{
  imports = [
    ./plasma.nix
  ];

  options.cfg.desktop = {
    enable = lib.mkEnableOption "Whether to enable a desktop environment";
    # The desktop environment to use. Currently only "plasma" is supported.
    manager = lib.mkOption {
      type = lib.types.enum [ "plasma" ];
      default = "plasma";
      description = "The desktop environment to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Setup sddm
    services.displayManager.sddm = {
      enable = true;
    };

    environment.systemPackages = [
      # Set background of the breeze theme
      (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
        [General]
        background=${user.wallpaper.lockscreen}
      '')
      # Set user profile icon
      (pkgs.runCommand "user-icons" {} ''
        mkdir -p $out/share/sddm/faces
        ln -s ${user.profileImage} $out/share/sddm/faces/${user.username}.face.icon
      '')
    ];
  };
}