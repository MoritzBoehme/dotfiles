{ config, lib, pkgs, ... }:

let
  base = (home: {
    programs.rofi = {
      enable = true;
      # theme = ~/.dotfiles/config/rofi/dracula_old.rasi;
      theme = ./dracula.rasi;
    };
  });
in
{
  home-manager.users.moritz = {...}: (base "/home/moritz/");
}
