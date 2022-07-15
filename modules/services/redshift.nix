{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.my.services.redshift;
in
{
  options.my.services.redshift = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = lib.mkIf cfg.enable {
    services.redshift.enable = true;
    location = {
      latitude = 52.3;
      longitude = 12.4;
    };
  };
}
