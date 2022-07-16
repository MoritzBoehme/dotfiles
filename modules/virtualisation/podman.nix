{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.virtualisation.podman;
in
{
  options.my.virtualisation.podman = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = false;
    };
  };

  config = mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
