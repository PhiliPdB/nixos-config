{ config, lib, pkgs, user, meta, ... }:
let
  colorThemeName = "MaterialDarker";
  # TODO: Generate from stylix?!
  colorTheme = builtins.readFile (meta.themesPath + "/color-schemes/${colorThemeName}.colors");
in
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
    # Disable stylix theming for KDE Plasma
    stylix.targets.kde.enable = false;

    home.packages = [
      # Write color scheme
      (pkgs.writeTextDir "share/color-schemes/${colorThemeName}.colors" colorTheme)
    ];

    programs.plasma = {
      enable = true;

      workspace = {
        wallpaper = user.wallpaper.desktop;
        lookAndFeel = "org.kde.breezedark.desktop";
        iconTheme = "Papirus-Dark";
        colorScheme = "MaterialDarker";
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

      kscreenlocker = {
        appearance.wallpaper = user.wallpaper.lockscreen;

        timeout = lib.mkDefault 10;
        passwordRequiredDelay = lib.mkDefault 5;
      };
    };
  };
}
