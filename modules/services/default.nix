{ config
, lib
, pkgs
, ...
}: {
  imports = [
    ./dunst.nix
    ./kdeconnect.nix
    ./openconnect.nix
    ./openvpn.nix
    ./picom.nix
    ./printing.nix
    ./redshift.nix
  ];
}
