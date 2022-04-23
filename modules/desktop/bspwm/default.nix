{ config, lib, pkgs, ... }:

let cfg = config.modules.desktop;
in {
  imports = [ ./polybar.nix ];

  config = lib.mkIf (cfg.name == "bspwm") {
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
        settings = with config.scheme.withHashtag; {
          border_width = 2;
          window_gap = 5;
          borderless_monocle = true;
          gapless_monocle = true;
          focus_follows_pointer = true;

          # Dracula theme #
          focused_border_color = base0D;
          normal_border_color = base03;
          active_border_color = base03;
        };
        startupPrograms = [
          "${pkgs.systemd}/bin/systemctl --user start polybar.service"
          "randomWallpaper"
          "synology-drive"
        ];
        extraConfig = ''
          # MONITORS #
          monitors=($(bspc query -M --names | sort -r))
          desktops=$(expr 10 / ''${#monitors[@]})
          start=1
          end=$desktops
          for monitor in ''${monitors[@]}; do
              bspc monitor $monitor -d $(seq -s ' ' $start $end)
              start=$(expr $start + $desktops)
              end=$(expr $end + $desktops)
          done
        '';

      };
      services.sxhkd = {
        enable = true;
        extraConfig = builtins.readFile ./sxhkdrc;
      };

      home.packages = with pkgs; [ feh playerctl pamixer brightnessctl ];
    };
  };
}
