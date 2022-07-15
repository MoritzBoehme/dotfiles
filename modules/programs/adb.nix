{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.programs.adb;
in
{
  options.my.programs.adb = {
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
