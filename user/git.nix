{ lib, user, ... }:
{
  programs.git = {
    enable = true;

    userName = user.githubName;
    userEmail = user.email;

    signing = {
      key = user.gpgKey;
      signByDefault = true;
    };
  };

  # Enable gh by default
  programs.gh = {
    enable = lib.mkDefault true;
  };
}
