{ config, lib, pkgs, ...}:
let
  guiAppsEnabled = config.cfg.guiApplications;
  cfg = config.cfg.programs.steam;
in
{
  options.cfg.programs.steam = {
    enable = lib.mkEnableOption "Whether to enable Steam and gaming related applications";
  };

  config = lib.mkIf (guiAppsEnabled && cfg.enable) {
    # Enable steam
    programs.steam = {
      enable = true;

      # Setup the firewall
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      gamescopeSession.enable = true;
    };
    # Enable gamemode
    programs.gamemode.enable = true;


    # Install proton
    environment.systemPackages = with pkgs; [
      protonup-qt
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATH = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
}