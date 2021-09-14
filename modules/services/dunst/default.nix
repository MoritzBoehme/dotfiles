{ config, lib, pkgs, ... }:

let
  base = {
    xdg = {
      enable = true;
      configFile."dunt/dunstrc" = {
        source = ./dunstrc;
      };
    };
    services.dunst.enable = true;
  };
in
{
  home-manager.users.moritz = {...}: (base);
}
