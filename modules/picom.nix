{ config, lib, pkgs, ... }:

let
  base = {
    services.picom = {
      enable = true;
      inactiveOpacity = "0.95";
      opacityRule = [
        "100:fullscreen"
        "80 :class_g   = 'Polybar'"
      ];
      blur = true;
      inactiveDim = "0.1";
    };
    extraOptions = ''
                   corner-radius = 10;
                   rounded-cornes-exclude = [
                     "class_g = 'Polybar'",
                     "class_g = 'Rofi'"
                   ]
                   round-borders = 1;
                   '';
  };
in
{
  home-manager.users.moritz = {...}: (base);
}
