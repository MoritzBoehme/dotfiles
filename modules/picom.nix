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
      experimentalBackends = true;
      extraOptions = ''
                     corner-radius = 10;
                     rounded-cornes-exclude = [
                       "class_g = 'Polybar'",
                       "class_g = 'Rofi'"
                     ]
                     round-borders = 1;

                     # improve performance
                     glx-no-rebind-pixmap = true;
                     glx-no-stencil = true;

                     # fastest swap method
                     glx-swap-method = 1;

                     # dual kawase blur
                     blur-background-fixed = false;
                     # blur-method = "dual_kawase";
                     blur-strength = 10;
                     use-ewmh-active-win = true;
                     detect-rounded-corners = true;

                     # stop compositing if there's a fullscreen program
                     unredir-if-possible = true;

                     # group wintypes and don't focus a menu (Telegram)
                     detect-transient = true;
                     detect-client-leader = true;

                     # needed for nvidia with glx backend
                     xrender-sync-fence = true;
                     '';
      };
    };
in
{
  home-manager.users.moritz = {...}: (base);
}
