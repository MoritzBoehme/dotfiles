{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.programs.bspwm;
in
{
  options.my.programs.bspwm = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = lib.mkIf cfg.enable {
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
          lightdm.enable = true;
        };
        windowManager.bspwm.enable = true;
      };
    };

    home-manager.users.moritz = {
      xsession.windowManager.bspwm = {
        enable = true;
        rules = {
          "Zathura".state = "tiled";
          "Emacs".state = "tiled";
          "feh".state = "floating";
          "Vampire_Survivors".state = "fullscreen";
        };
        settings = with config.scheme.withHashtag; {
          border_width = 2;
          window_gap = 5;
          borderless_monocle = true;
          gapless_monocle = true;
          focus_follows_pointer = true;
        };
        startupPrograms = [
          "${pkgs.systemd}/bin/systemctl --user start polybar.service"
          "randomWallpaper"
          "synology-drive"
        ];
        extraConfig = builtins.readFile ./bspwmrc;
      };
      services = {
        sxhkd = {
          enable = true;
          extraConfig = builtins.readFile ./sxhkdrc;
        };
        polybar = {
          enable = true;
          package = pkgs.polybar.override { pulseSupport = true; };
          script = ''
            for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
                MONITOR=$m polybar --reload bottom &
            done
          '';
        };
      };

      home.packages = with pkgs; [ feh playerctl pamixer brightnessctl ];
    };
  };
}
