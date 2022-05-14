{ config, lib, pkgs, ... }:

{
  nix = {
    gc = {
      automatic = true;
      options = "--max-freed $((32 * 1024**3)) --delete-older-than 14d";
      dates = "weekly";
    };
    optimise.automatic = true;

    settings.trusted-users = [ "root" "@wheel" ];
  };
}
