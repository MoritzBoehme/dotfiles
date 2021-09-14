{ config, lib, pkgs, ... }:

{
  imports = [
    ./dunst
    ./diskstation
    ./emacs
    ./agenix.nix
    ./picom.nix
  ];

  home-manager.users.moritz.services = {
      kdeconnect.enable = true;
  };
}
