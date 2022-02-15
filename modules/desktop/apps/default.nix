{ config, lib, pkgs, ... }:

{
  imports = [
    ./email.nix
    ./firefox.nix
    ./kitty.nix
    ./rofi
    ./spotify.nix
    ./zathura.nix
  ];
  home-manager.users.moritz = {
    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
    home.packages = with pkgs; [
      anki
      calibre
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
  users.extraGroups.vboxusers.members = [ "moritz" ];
  services.gvfs = {
    enable = true;
    package = lib.mkForce pkgs.gnome3.gvfs;
  };
}
