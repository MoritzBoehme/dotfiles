{ config, lib, pkgs, ... }:

{
  programs.steam.enable = true;
  home-manager.users.moritz.home.packages = with pkgs; [ lutris ];
}
