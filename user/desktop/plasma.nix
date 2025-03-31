{ config, lib, user, ... }:
{
  options = {
    plasma = {
      pinnedItems = lib.mkOption {
        description = "List of programs to pin to the taskbar";
        type = with lib.types; listOf str;

        default = [
          "preferred://filemanager"
          "preferred://browser"
          "applications:code.desktop"
        ];
      };

      systemTray = {
        itemsShown = lib.mkOption {
          description = "List of items to show on the systemtray";
          type = with lib.types; listOf str;

          default = [
            "org.kde.plasma.volume"
            "org.kde.plasma.networkmanagement"
          ];
        };
        itemsHidden = lib.mkOption {
          description = "List of items to hide from the systemtray";
          type = with lib.types; listOf str;

          default = [
            "steam"
            "org.kde.plasma.clipboard"
            "org.kde.plasma.brightness"
          ];
        };
      };
    };
  };

  config = lib.mkIf (user.desktop == "plasma") {
    programs.plasma = {
      enable = true;

      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        iconTheme = "Papirus-Dark";
      };

      # Set virtual desktops
      kwin.virtualDesktops = {
        number = 5;
        rows = 1;
      };

      # Set panel layout
      panels = [
        { # Bottom panel (Windows like)
          location = "bottom";
          alignment = "center";
          lengthMode = "fill";
          floating = true;
          height = 32;
          screen = "all";

          widgets = [
            {
              kickoff = {
                icon = "start-here";
                # TODO: Figure out hibernate button
                # showButtonsFor = [
                #   "hibernate"
                #   "reboot"
                #   "shutdown"
                # ];
                showActionButtonCaptions = false;
              };
            }
            {
              iconTasks = {
                launchers = config.plasma.pinnedItems;
              };
            }
            "org.kde.plasma.marginsseparator"
            {
              systemTray = {
                items.shown = config.plasma.systemTray.itemsShown;
                items.hidden = config.plasma.systemTray.itemsHidden;
              };
            }
            {
              digitalClock = {
                date.enable = false;
              };
            }
            "org.kde.plasma.notifications"
          ];
        }
      ];

      # Set shortcuts
      shortcuts = {
        "kwin"."Overview" = "Meta+Tab";
        # Meta+I to open system settings
        "services/systemsettings.desktop"."_launch" = ["Meta+I" "Tools"];
      };
    };
  };
}
