{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop;
in {
  config = mkIf (cfg.name == "sway") {
    hardware.opengl = {
      enable = true;
      driSupport = true;
    };
    home-manager.users.moritz = {
      wayland.windowManager.sway = {
        enable = true;
        terminal = "kitty";
        menu = "wofi --show run";
        bars = [{
          fonts.size = 15.0;
          positiom = "bottom";
        }];
      };
    };
  };
}
