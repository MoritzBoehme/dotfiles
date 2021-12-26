{ config, lib, pkgs, ... }:

let
  cheat = import ./cheat.nix { inherit pkgs; };
  cycleSinks = import ./cycleSinks.nix { inherit pkgs; };
  protonge = import ./protonge.nix { inherit pkgs; };
  sxhkdHelp = import ./sxhkdHelp.nix { inherit pkgs; };
in {
  home-manager.users.moritz.home.packages =
    [ cycleSinks cheat sxhkdHelp protonge ];
}
