{ ... }:
{
  virtualisation.docker = {
    enable = true;

    autoPrune = {
      enable = true;
      dates = "weekly";
      # Filter stuff older than 30 days
      flags = [ "-af" "--filter 'until=720h'" ];
    };
  };
}
