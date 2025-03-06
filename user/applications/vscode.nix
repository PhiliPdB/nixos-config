{ pkgs, ... }:
{
  # TODO: Determine if we want to rely on sync or declare config here
  # programs.vscode = {
  #   enable = true;
  #   package = pkgs-unstable.vscode;
  # };

  home.packages = with pkgs; [
    vscode
    vscode-runner
  ];
}
