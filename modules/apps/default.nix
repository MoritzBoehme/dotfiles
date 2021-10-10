{ config, lib, pkgs, ... }:

{
  imports = [ ./rofi ./kitty.nix ./zathura.nix ./email.nix ];
  home-manager.users.moritz.home.packages = with pkgs; [
    neofetch
    unstable.keepassxc
    unstable.spotify
    spicetify-cli
    xfce.thunar
    xfce.xfconf
    xfce.tumbler
    xfce.exo
    libreoffice
  ];
}
