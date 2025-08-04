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

    aliases = {
      r = "rebase";
      rc = "rebase --continue";
      ri = "rebase --interactive";
    };
  };

  # Enable gh by default
  programs.gh = {
    enable = lib.mkDefault true;

    settings = {
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };
  };
}
