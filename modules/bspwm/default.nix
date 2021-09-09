{ config, lib, pkgs, ... }:

let
  base = {
    xdg = {
      enable = true;
      configFile = {
        "bspwm/bspwmrc" = {
          source = ./bspwmrc;
          onChange = "bspc wm -r";
        };
      "sxhkd/sxhkdrc" = {
          source = ./sxhkdrc;
          onChange = "pkill -USR1 -x sxhkd";
        };
      };
    };
    home.packages = with pkgs; [
      feh
    ];
  };
in
{
  home-manager.users.moritz = {...}: (base);
}
