{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz.programs.zathura = {
    enable = true;
    options = {
      recolor = true;
      adjust-open = "width";
      font = "Jetbrains Mono 9";
      selection-clipboard = "clipboard";
    };
  };
}
