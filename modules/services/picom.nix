{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {
    services.picom = {
      enable = true;
      package = pkgs.picom-next;
      blur = true;
      blurExclude = [ "class_g = 'Polybar'" ];
      experimentalBackends = true;
      inactiveOpacity = "0.97";
      opacityRule = [ "100:fullscreen" "100:class_g   = 'Polybar'" ];
      vSync = true;
      extraOptions = ''
        # improve performance
        glx-no-rebind-pixmap = true;
        glx-no-stencil = true;

        # fastest swap method
        glx-swap-method = 1;

        # dual kawase blur
        blur-background-fixed = false;
        blur-method = "dual_kawase";
        blur-strength = 2;

        # group wintypes and don't focus a menu (Telegram)
        detect-transient = true;
        detect-client-leader = true;

        # needed for nvidia with glx backend
        xrender-sync-fence = true;
      '';
    };
  };
}
