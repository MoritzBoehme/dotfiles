{ config, lib, pkgs, ... }:

{
  imports = [ ./rofi ./kitty.nix ./zathura.nix ./spotify.nix ./firefox.nix ];
  home-manager.users.moritz = {
    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
    home.packages = with pkgs; [
      anki
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
