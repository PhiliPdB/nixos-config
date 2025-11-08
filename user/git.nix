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
      s = "status";

      r = "rebase";
      rc = "rebase --continue";
      ri = "rebase --interactive";

      w = "worktree";
      wls = "worktree list";
      wa = "worktree add";
      wr = "worktree remove";
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
