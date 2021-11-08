{ config, lib, pkgs, ... }:

{
  imports = [ ./dunst ./agenix.nix ./diskstation ./picom.nix ];

  home-manager.users.moritz.services = { kdeconnect.enable = true; };

  services = {
    printing.enable = true;
    printing.drivers = with pkgs; [ epson-escpr2 epson-escpr ];
    avahi = {
      enable = true;
      nssmdns = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };
}
