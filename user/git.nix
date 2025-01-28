{ user, ... }:
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
}