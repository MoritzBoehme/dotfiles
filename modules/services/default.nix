{ config, lib, pkgs, ... }:

{
  imports = [
    ./agenix.nix
    ./dunst.nix
    ./gpg.nix
    ./kdeconnect.nix
    ./keyring.nix
    ./openvpn.nix
    ./picom.nix
    ./openconnect.nix
  ];

  services = {
    printing = {
      enable = true;
      drivers = with pkgs;
        [ stable.epson-escpr2 ]; # HACK to fix broken upstream package
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
