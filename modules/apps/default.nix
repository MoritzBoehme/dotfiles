{ config, lib, pkgs, ... }:

{
  imports = [ ./rofi ./kitty.nix ./zathura.nix ./email.nix ./spotify.nix ];
  home-manager.users.moritz.home.packages = with pkgs; [
    neofetch
    keepassxc
    xfce.thunar
    xfce.xfconf
    xfce.tumbler
    xfce.exo
    libreoffice
    signal-desktop
  ];
}
