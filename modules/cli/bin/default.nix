{ config, lib, pkgs, ... }:

let
  cheat = import ./cheat.nix { inherit pkgs; };
  cycleSinks = import ./cycleSinks.nix { inherit pkgs; };
  git-switch = import ./git-switch.nix { inherit pkgs; };
  protonge = import ./protonge.nix { inherit pkgs; };
  randomWallpaper = import ./randomWallpaper.nix { inherit pkgs; };
  share = import ./share.nix { inherit pkgs; };
  sxhkdHelp = import ./sxhkdHelp.nix { inherit pkgs; };
in
{
  home-manager.users.moritz.home.packages =
    [ cheat cycleSinks git-switch protonge randomWallpaper share sxhkdHelp ];
}
