{ config, lib, pkgs, ... }:

{
  imports = [
    ./dunst
    ./emacs
    ./agenix.nix
    ./diskstation.nix
    ./picom.nix
  ];

  home-manager.users.moritz.services = {
      kdeconnect.enable = true;
  };
}
