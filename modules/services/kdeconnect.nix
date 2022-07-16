{ config
, lib
, pkgs
, ...
}:

with lib;
let
  ports = {
    from = 1714;
    to = 1764;
  };
  cfg = config.my.services.kdeconnect;
in
{
  options.my.services.kdeconnect = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.moritz.services.kdeconnect.enable = true;
    networking.firewall = {
      allowedTCPPortRanges = [ ports ];
      allowedUDPPortRanges = [ ports ];
    };
  };
}
