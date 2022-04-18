{ config, lib, pkgs, ... }:

{
  services.udev.packages = [ pkgs.yubikey-personalization ];
  home-manager.users.moritz.home.packages = with pkgs; [
    # cli
    yubikey-manager
    yubikey-personalization
    paperkey
    stable.haskellPackages.hopenpgp-tools
    # graphical
    yubikey-manager-qt
    yubikey-personalization-gui
  ];
}
