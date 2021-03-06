{ config, lib, pkgs, ... }:

{
  imports = [
    ./email.nix
    ./firefox.nix
    ./kitty.nix
    ./rofi
    ./zathura.nix
    ./virtualisation.nix
  ];
  home-manager.users.moritz = {
    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
    home.packages = with pkgs; [
      tlaplusToolbox
      anki
      calibre
      gparted
      jellyfin-media-player
      keepassxc
      libreoffice
      neofetch
      pavucontrol
      picard
      signal-desktop
      vlc
      xfce.exo
      xfce.thunar
      xfce.tumbler
      xfce.xfconf
    ];
  };
  services.gvfs = {
    enable = true;
    package = lib.mkForce pkgs.gnome3.gvfs;
  };
}
