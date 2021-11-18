{ config, lib, pkgs, ... }:

{
  imports = [ ./rofi ./kitty.nix ./zathura.nix ./spotify.nix ./firefox.nix ];
  home-manager.users.moritz.home.packages = with pkgs; [
    neofetch
    keepassxc
    xfce.thunar
    xfce.xfconf
    xfce.tumbler
    xfce.exo
    libreoffice
    signal-desktop
    anki
  ];
  services.gvfs = {
    enable = true;
    package = lib.mkForce pkgs.gnome3.gvfs;
  };
}
