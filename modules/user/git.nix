{ lib, user, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = user.githubName;
        email = user.email;
      };

      alias = {
        c = "commit";
        s = "status";

        fa = "fetch --all";

        r = "rebase";
        rc = "rebase --continue";
        ri = "rebase --interactive";

        w = "worktree";
        wls = "worktree list";
        wa = "worktree add";
        wr = "worktree remove";
      };
    };

    signing = {
      key = user.gpgKey;
      signByDefault = true;
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

      # Turn telemetry off
      telemetry = "disabled";
    };
  };
}
