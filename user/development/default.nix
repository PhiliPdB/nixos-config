{ ... }: {
  imports = [
    ./lua.nix
    ./nix.nix
  ];

  # Enable direnv
  programs.direnv = {
    enable = true;

    nix-direnv.enable = true;
  };
}
