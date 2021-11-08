{ config, lib, pkgs, ... }:

{
  imports = [ ./dunst ./agenix.nix ./diskstation ./picom.nix ];

  home-manager.users.moritz.services = { kdeconnect.enable = true; };

  services = {
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };
}
