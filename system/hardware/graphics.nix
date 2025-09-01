{ lib, config, ... }:
let
  cfg = config.cfg.graphics;
in
{
  options.cfg.graphics = {
    enable = lib.mkEnableOption "Enable hardware graphics";

    manufacturer = lib.mkOption {
      type =
        with lib.types;
        enum [
          "amd"
          "nvidia"
        ];
      description = "The manufacturer of the GPU.";
    };
  };

  config = lib.mkIf cfg.enable (
    {
      # Enable hardware graphics
      hardware.graphics.enable = true;
    }
    # Enable driver specific options
    // lib.mkIf (cfg.manufacturer == "nvidia") {
      services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];
      hardware.nvidia = {
        open = lib.mkDefault false;
        powerManagement.enable = lib.mkDefault true;
      };
    }
  );
}
