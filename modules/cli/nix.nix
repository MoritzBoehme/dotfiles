{ config, lib, pkgs, ... }:

{
  nix.package = pkgs.nixFlakes;
  nix.gc = {
    automatic = true;
    options = "--max-freed $((32 * 1024**3)) --delete-older-than 14d";
  };
  nix.optimise.automatic = true;
}
