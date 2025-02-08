{ ... }:
{
  # Set timezone
  time.timeZone = "Europe/Amsterdam";

  # Set locales
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_COLLATE = "C.UTF-8";
      LC_NUMERIC = "C.UTF-8";
      
      LC_TIME = "nl_NL.UTF-8";
      LC_MONETARY = "nl_NL.UTF-8";
      LC_PAPER = "nl_NL.UTF-8";
      LC_MEASUREMENT = "nl_NL.UTF-8";
      LC_IDENTIFICATION = "nl_NL.UTF-8";
      LC_ADDRESS = "nl_NL.UTF-8";
      LC_TELEPHONE = "nl_NL.UTF-8";
    };
  };

  # Set Keyboard layout

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };
  # Configure console keymap
  console.keyMap = "us-acentos";
}