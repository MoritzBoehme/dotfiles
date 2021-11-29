{ config, lib, pkgs, ... }:

{
  imports = [ ./rofi ./kitty.nix ./zathura.nix ./spotify.nix ./firefox.nix ];
  home-manager.users.moritz.home.packages = with pkgs; [
    anki
    keepassxc
    libreoffice
    neofetch
    pavucontrol
    signal-desktop
    virtualboxWithExtpack
    xfce.exo
    xfce.thunar
    xfce.tumbler
    xfce.xfconf
  ];
  services.gvfs = {
    enable = true;
    package = lib.mkForce pkgs.gnome3.gvfs;
  };
}
