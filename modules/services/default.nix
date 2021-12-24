{ config, lib, pkgs, ... }:

{
  imports = [
    ./agenix.nix
    ./diskstation
    ./dunst
    ./jupyter.nix
    ./kdeconnect.nix
    ./picom.nix
  ];

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
    redshift = { enable = true; };
  };
  location = {
    latitude = 52.3;
    longitude = 12.4;
  };
}
