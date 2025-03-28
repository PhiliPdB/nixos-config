{ pkgs, lib, ...}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";

    baseIndex = 1;
    shortcut = " ";
  };
}
