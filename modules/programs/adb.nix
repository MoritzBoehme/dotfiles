{ config, lib, pkgs, ... }:

with lib;

let cfg = config.our.programs.adb;
in {
  options.our.programs.adb = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = mkIf cfg.enable {
    programs.adb.enable = true;
    users.users.moritz.extraGroups = [ "adbusers" ];
  };
}
