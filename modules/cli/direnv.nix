{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz.programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
      enableFlakes = true;
    };
  };
}
