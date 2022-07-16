{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.bin;
  cycleSinks = import ./cycleSinks.nix { inherit pkgs; };
  protonge = import ./protonge.nix { inherit pkgs; };
  randomWallpaper = import ./randomWallpaper.nix { inherit pkgs; };
  share = import ./share.nix { inherit pkgs; };
  sxhkdHelp = import ./sxhkdHelp.nix { inherit pkgs; };
in
{
  options.my.bin = {
    enable = mkOption {
      default = true;
      type = types.bool;
      example = false;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cycleSinks
      protonge
      randomWallpaper
      share
      sxhkdHelp
    ];
  };
}
