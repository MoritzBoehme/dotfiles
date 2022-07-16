{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.programs.hub;
in
{
  options.my.programs.hub = {
    enable = mkOption {
      default = true;
      type = types.bool;
      example = false;
    };
  };
  config = mkIf cfg.enable {
    age.secrets = {
      github = {
        file = ../../secrets/github.age;
        owner = "1000";
      };
    };
  };
}
