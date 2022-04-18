{ config, lib, pkgs, ... }:

{
  nix = {
    package = pkgs.nix_2_4;
    gc = {
      automatic = true;
      options = "--max-freed $((32 * 1024**3)) --delete-older-than 14d";
      dates = "weekly";
    };
    optimise.automatic = true;
  };
}
