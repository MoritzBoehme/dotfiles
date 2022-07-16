{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.my.services.printing;
in
{
  options.my.services.printing = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      printing = {
        enable = true;
        drivers = with pkgs; [ stable.epson-escpr2 ]; # HACK to fix broken upstream package
      };
      avahi = {
        enable = true;
        nssmdns = true;
      };
    };
  };
}
