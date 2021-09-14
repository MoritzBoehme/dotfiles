{ config, lib, pkgs, ... }:

{
  imports = [
    ./rofi
    ./kitty.nix
    ./zathura.nix
  ];
  home-manager.users.moritz.home.packages = with pkgs; [
    neofetch
    unstable.keepassxc
    unstable.spotify
    spicetify-cli
  ];
}
