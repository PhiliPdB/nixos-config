{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cfg.docker;
in
{
  options.cfg.docker = {
    enable = lib.mkEnableOption "Enable Docker and related tools";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.containers.enable = true;
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      # Required for containers under podman-compose to talk to each other.
      defaultNetwork.settings.dns_enabled = true;

      autoPrune = {
        enable = true;
        dates = "weekly";
        # Filter stuff older than 30 days
        flags = [
          "-af"
          "--filter until=720h"
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      podman-compose # To replace docker-compose
      podman-desktop # GUI for podman
    ];

    environment.sessionVariables = {
      PODMAN_COMPOSE_WARNING_LOGS = "false";
    };
  };
}
