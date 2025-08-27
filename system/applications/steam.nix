{ config, lib, pkgs, ...}:
{
  options = {
    steam.enable = lib.mkEnableOption "Enable Steam and gaming related applications";
  };

  config = lib.mkIf config.steam.enable {
    # Enable steam
    programs.steam = {
      enable = true;

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

    # Remember to run protonup after first installation
  };
}