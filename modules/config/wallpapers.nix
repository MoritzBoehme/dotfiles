{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.wallpapers;
in
{
  options.my.wallpapers = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.moritz.xdg = {
      enable = true;
      configFile = {
        "wallpapers/" = {
          source = ./wallpapers;
          recursive = true;
        };
      };
    };
  };
}
