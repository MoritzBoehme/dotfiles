{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      layout = "de";

      displayManager = {
        defaultSession = "none+bspwm";

        autoLogin = {
          enable = true;
          user = "moritz";
        };
        lightdm = {
          enable = true;
        };
      };
      windowManager.bspwm.enable = true;
    };
  };
  home-manager.users.moritz = {
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
      brightnessctl
    ];
  };
}
