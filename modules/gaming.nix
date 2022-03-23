{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.gaming;
in {
  options.modules.gaming = mkOption {
    default = false;
    type = types.bool;
    example = true;
  };

  config = mkIf cfg {
    programs.steam.enable = true;
    home-manager.users.moritz.home.packages = with pkgs; [
      lutris
      legendary-gl
    ];
  };
}
