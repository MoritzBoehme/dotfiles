{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.programs.direnv;
in
{
  options.my.programs.direnv = {
    enable = mkOption {
      default = true;
      type = types.bool;
      example = false;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.moritz.programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
