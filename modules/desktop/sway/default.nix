{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop;
in {
  config = mkIf (cfg.name == "sway") {
    hardware.opengl = {
      enable = true;
      driSupport = true;
    };
    environment.loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec sway
      fi
    '';
    home-manager.users.moritz = {
      home.packages = with pkgs; [ wl-clipboard wofi waybar feh ];
      programs.waybar = {
        enable = true;
        systemd.enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 30;
            output = [ "eDP-1" "HDMI-A-1" ];
            modules-left = [ "sway/workspaces" "sway/mode" "wlr/taskbar" ];
            modules-center = [ "sway/window" "custom/hello-from-waybar" ];
            modules-right =
              [ "mpd" "custom/mymodule#with-css-id" "temperature" ];
            "sway/workspaces" = { all-outputs = true; };
          };
        };
      };
      wayland.windowManager.sway = {
        enable = true;
        config = {
          input = {
            "*" = { xkb_layout = "de"; };
            "type:touchpad" = {
              natural_scroll = "enabled";
              middle_emulation = "enabled";
            };
          };
          terminal = "kitty";
          menu = "wofi --show drun";
          modifier = "Mod4";
          gaps = {
            inner = 5;
            outer = 3;
            smartBorders = "on";
          };
          bars = [ ];
          keybindings = let
            modifier =
              config.home-manager.users.moritz.wayland.windowManager.sway.config.modifier;
          in lib.mkOptionDefault {
            "${modifier}+f" = "firefox";
            "${modifier}+e" = "emacsclient -c -a emacs";
          };
          startup = [
            {
              command = "systemctl --user restart waybar";
              always = true;
            }
            { command = "synology-drive"; }
            { command = "randomWallpaper"; }
          ];
        };
      };
    };
  };
}
