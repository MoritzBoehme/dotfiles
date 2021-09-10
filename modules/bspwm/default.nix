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
      };
    };
    home.packages = with pkgs; [
      feh
    ];
  };
in
{
  # SERVICES
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
    };
  };
  home-manager.users.moritz = {...}: (base);
}
