{ config, lib, pkgs, ... }:

let
  cycleSinks = import ./cycleSinks.nix { inherit pkgs; };
  protonge = import ./protonge.nix { inherit pkgs; };
  randomWallpaper = import ./randomWallpaper.nix { inherit pkgs; };
  share = import ./share.nix { inherit pkgs; };
  sxhkdHelp = import ./sxhkdHelp.nix { inherit pkgs; };
in {
  home-manager.users.moritz.home.packages =
    [ cycleSinks protonge randomWallpaper share sxhkdHelp ];
}
