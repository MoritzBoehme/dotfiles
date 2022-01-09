{ config, lib, pkgs, ... }:
let
  ports = {
    from = 1714;
    to = 1764;
  };
in {
  home-manager.users.moritz.services.kdeconnect.enable = true;
  networking.firewall = {
    allowedTCPPortRanges = [ ports ];
    allowedUDPPortRanges = [ ports ];
  };
}
