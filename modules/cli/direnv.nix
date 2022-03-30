{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
