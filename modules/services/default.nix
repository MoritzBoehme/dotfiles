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
    printing = {
      enable = true;
      drivers = with pkgs; [ epson-escpr2 epson-escpr ];
    };
    avahi = lib.mkIf config.services.printing.enable {
      enable = true;
      nssmdns = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    redshift.enable = true;
  };
  location = {
    latitude = 52.3;
    longitude = 12.4;
  };
}
