{ config, lib, pkgs, ... }:

let
  base = (home: {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi.override { plugins = with pkgs; [ rofi-calc ]; };
      theme = ./dracula.rasi;
    };
    home.packages = with pkgs; [ networkmanager_dmenu ];
    xdg = {
      enable = true;
      configFile."networkmanager-dmenu/config.ini".text = ''
        [dmenu]
        dmenu_command = rofi
      '';
    };
  });
in { home-manager.users.moritz = { ... }: (base "/home/moritz/"); }
