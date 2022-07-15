{ config, lib, pkgs, ... }:

with lib;

let
  folder = ./.;
  toImport = name: value: folder + ("/" + name);
  filterCaches = key: value:
    value == "regular" && lib.hasSuffix ".nix" key && key != "default.nix";
  imports = lib.mapAttrsToList toImport
    (lib.filterAttrs filterCaches (builtins.readDir folder));

  cfg = config.our.programs.nix;
in {
  inherit imports;

  options.our.programs.nix = {
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

  nix = {
    gc = mkIf cfg.gc.enable {
      automatic = true;
      options = "--max-freed $((32 * 1024**3)) --delete-older-than 14d";
      dates = "weekly";
    };

    optimise = mkIf cfg.optimise.enable {
      automatic = true;
      dates = "weekly";
    };

    settings = {
      substituters = [ "https://cache.nixos.org/" ];
      trusted-users = [ "root" "@wheel" ];
    };
  };
}
