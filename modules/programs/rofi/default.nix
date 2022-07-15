{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.programs.rofi;
in
{
  options.my.programs.rofi = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.moritz = {
      programs.rofi = {
        enable = true;
        package =
          pkgs.rofi.override { plugins = with pkgs; [ rofi-calc rofi-emoji ]; };
        extraConfig = { combi-modi = "drun,window,emoji"; };
      };
      home.packages = with pkgs; [
        (lib.mkIf config.networking.networkmanager.enable networkmanager_dmenu)
      ];
      xdg = {
        enable = true;
        configFile."networkmanager-dmenu/config.ini".text = ''
          [dmenu]
          dmenu_command = rofi
        '';
      };
    };
  };
}
