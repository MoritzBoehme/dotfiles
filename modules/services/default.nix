{ config, lib, pkgs, ... }:

{
  imports = [
    ./agenix.nix
    ./diskstation
    ./dunst
    ./gpg.nix
    ./jupyter.nix
    ./kdeconnect.nix
    ./keyring.nix
    ./openvpn.nix
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
    btrfs.autoScrub.enable = lib.mkDefault
      (builtins.any (filesystem: filesystem.fsType == "btrfs")
        (builtins.attrValues config.fileSystems));
  };
  location = {
    latitude = 52.3;
    longitude = 12.4;
  };
}
