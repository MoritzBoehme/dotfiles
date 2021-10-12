{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {
    gtk = {
      enable = true;
      theme = {
        package = pkgs.dracula-theme;
        name = "Dracula";
      };
    };
  };
  programs.dconf.enable = true;
}
