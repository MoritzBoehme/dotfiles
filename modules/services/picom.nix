{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {

    services.picom = {
      enable = true;
      inactiveOpacity = "0.90";
      opacityRule = [ "100:fullscreen" "100:class_g   = 'Polybar'" ];
      blur = true;
      blurExclude = [ "class_g = 'Polybar'" ];
      experimentalBackends = true;
      extraOptions = ''
        corner-radius = 10;
        rounded-corners-exclude = [
          "class_g = 'Polybar'"
        ]
        round-borders = 1;

        # improve performance
        glx-no-rebind-pixmap = true;
        glx-no-stencil = true;

        # fastest swap method
        glx-swap-method = 1;

        # dual kawase blur
        blur-background-fixed = false;
        blur-method = "dual_kawase";
        blur-strength = 2;
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
}
