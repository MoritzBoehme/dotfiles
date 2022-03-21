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
        lightdm = { enable = true; };
      };
      windowManager.bspwm.enable = true;
    };
  };

  console.keyMap = "de";

  home-manager.users.moritz = {
    xsession.windowManager.bspwm = {
      enable = true;
      rules = {
        "Zathura" = { state = "tiled"; };
        "Emacs" = { state = "tiled"; };
        "feh" = { state = "floating"; };
        "Vampire_Survivors" = { state = "fullscreen"; };
      };
      settings = {
        border_width = 2;
        window_gap = 5;
        borderless_monocle = true;
        gapless_monocle = true;
        focus_follows_pointer = true;

        # Dracula theme #
        focused_border_color = "#bd93f9";
        normal_border_color = "#44475a";
        active_border_color = "#6272a4";
      };
      startupPrograms = [
        "${pkgs.systemd}/bin/systemctl --user start polybar.service"
        "randomWallpaper"
        "synology-drive"
      ];
      extraConfig = builtins.readFile ./bspwmrc;

    };
    services.sxhkd = {
      enable = true;
      extraConfig = builtins.readFile ./sxhkdrc;
    };

    home.packages = with pkgs; [ feh playerctl pamixer brightnessctl ];
  };
}
