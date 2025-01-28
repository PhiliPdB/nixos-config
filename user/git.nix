{ ... }:
{
  programs.git = {
    enable = true;
    
    userName = "PhiliPdB";
    userEmail = "phlpdbrn@gmail.com";

    signing = {
      key = "4EC55FB707DC24C4";
      signByDefault = true;
    };
  };
}