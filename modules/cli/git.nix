{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {
    programs.git = {
      enable = true;
      userName = "Moritz Böhme";
      userEmail = "mail@moritzboeh.me";
      extraConfig.init.defaultBranch = "main";
      delta.enable = true;
      signing = {
        key = null;
        signByDefault = true;
      };
    };
  };
  programs.git = {
    enable = true;
    config.safe.directory = "/home/moritz/.dotfiles";
  };
}
