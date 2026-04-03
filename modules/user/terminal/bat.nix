{
  programs.bat = {
    enable = true;

    config = {
      style = "numbers,changes";
    };
  };

  home.shellAliases = {
    cat = "bat";
  };
}
