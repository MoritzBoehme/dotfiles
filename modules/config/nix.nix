{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.nix;
in
{
  options.my.nix = {
    gc.enable = mkOption {
      default = true;
      type = types.bool;
      example = false;
    };
    optimise.enable = mkOption {
      default = true;
      type = types.bool;
      example = false;
    };
  };

  config.nix = {
    gc = {
      automatic = cfg.gc.enable;
      options = "--max-freed $((32 * 1024**3)) --delete-older-than 14d";
      dates = "weekly";
    };

    optimise = {
      automatic = cfg.optimise.enable;
      dates = [ "weekly" ];
    };

    settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://jupyterwith.cachix.org"
        "https://nix-community.cachix.org"
        "https://pre-commit-hooks.cachix.org"
      ];
      trusted-public-keys = [
        "jupyterwith.cachix.org-1:/kDy2B6YEhXGJuNguG1qyqIodMyO4w8KwWH4/vAc7CI="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
      ];

      trusted-users = [ "root" "@wheel" ];
    };
  };
}
