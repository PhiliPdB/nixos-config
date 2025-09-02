{ lib, config, ... }:
let
  cfg = config.cfg.hardware.graphics;
in
{
  options.cfg.hardware.graphics = {
    enable = lib.mkEnableOption "Enable hardware graphics";

    manufacturer = lib.mkOption {
      type = lib.types.enum [ "nvidia" ]; # NOTE: Only NVIDIA is supported for now
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
        # Fixes issues with hibernation
        powerManagement.enable = lib.mkDefault true;
      };
    }
  );
}
