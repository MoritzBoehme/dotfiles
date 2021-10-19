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
      };
      settings = {
        border_width = 2;
        window_gap = 5;
        borderless_monocle = true;
        gapless_monocle = true;
        focus_follows_pointer = true;
      };
      startupPrograms = [
        "${pkgs.systemd}/bin/systemctl --user start polybar.service"
        "feh --bg-fill ~/.config/wallpaper/dracula.png"
      ];
      extraConfig = builtins.readFile ./bspwmrc;

    };
    services.sxhkd = {
      enable = true;
      extraConfig = builtins.readFile ./sxhkdrc;
    };

    xdg = {
      enable = true;
      configFile = { "wallpaper/dracula.png" = { source = ./dracula.png; }; };
    };
    home.packages = with pkgs; [ feh playerctl pamixer brightnessctl ];
  };
}
