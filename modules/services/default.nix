{ config, lib, pkgs, ... }:

{
  imports = [ ./dunst ./agenix.nix ./diskstation ./picom.nix ./kdeconnect.nix ];

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
