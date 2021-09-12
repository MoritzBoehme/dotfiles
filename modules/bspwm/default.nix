{ config, lib, pkgs, ... }:

let
  base = {
    xsession.windowManager.bspwm.enable = true;

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
        "wallpaper/dracula.png" = {
          source = ./dracula.png;
        };
      };
    };
    home.packages = with pkgs; [
      feh
      playerctl
      pamixer
    ];
  };
in
{
  home-manager.users.moritz = {...}: (base);
}
