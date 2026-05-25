{ config, lib, ... }:
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
  };
}
