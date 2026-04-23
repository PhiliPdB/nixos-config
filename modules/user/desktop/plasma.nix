{
  config,
  lib,
  pkgs,
  sysCfg,
  user,
  meta,
  ...
}:
let
  cfg = config.cfg.plasma;

  colorThemeName = "MaterialDarker";
  # TODO: Generate from stylix?!
  colorTheme = builtins.readFile (meta.themesPath + "/color-schemes/${colorThemeName}.colors");

  wallpaperPackage =
    pkgs.runCommandLocal "wallpaper-pack"
      {
        wallpaper = user.wallpaper.desktop;
        lockscreen = user.wallpaper.lockscreen;
      }
      ''
        mkdir -p $out/share/wallpapers
        cp $wallpaper $out/share/wallpapers/desktop.jpg
        cp $lockscreen $out/share/wallpapers/lockscreen.jpg
      '';
in
{
  options.cfg.plasma = {
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
          "org.kde.plasma.brightness"
          "org.kde.plasma.clipboard"
          "org.kde.plasma.notifications"
        ];
      };
    };
  };

  config = lib.mkIf (sysCfg.desktop.enable && sysCfg.desktop.manager == "plasma") {
    # Disable stylix theming for KDE Plasma
    stylix.targets.kde.enable = false;

    home.packages = [
      # Write color scheme
      (pkgs.writeTextDir "share/color-schemes/${colorThemeName}.colors" colorTheme)
      # Wallpaper package
      wallpaperPackage
    ];

    programs.plasma = {
      enable = true;

      workspace = {
        wallpaper = "${wallpaperPackage}/share/wallpapers/desktop.jpg";
        lookAndFeel = "org.kde.breezedark.desktop";
        iconTheme = "Papirus-Dark";
        colorScheme = "MaterialDarker";
        cursor = {
          theme = "Bibata-Original-Ice";
          size = 28;
        };
      };

      # Set virtual desktops
      kwin.virtualDesktops = {
        number = 5;
        rows = 1;
      };

      # Set panel layout
      panels = [
        {
          # Bottom panel (Windows like)
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
                showActionButtonCaptions = false;
              };
            }
            {
              iconTasks = {
                launchers = cfg.pinnedItems;
              };
            }
            "org.kde.plasma.marginsseparator"
            {
              systemTray = {
                items.shown = cfg.systemTray.itemsShown;
                items.hidden = cfg.systemTray.itemsHidden;
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
        "services/systemsettings.desktop"."_launch" = [
          "Meta+I"
          "Tools"
        ];
      };

      kscreenlocker = {
        appearance.wallpaper = "${wallpaperPackage}/share/wallpapers/lockscreen.jpg";

        timeout = lib.mkDefault 10;
        passwordRequiredDelay = lib.mkDefault 5;
      };
    };
  };
}
