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
        key = "0xE4F362A3F5C338A0";
        signByDefault = true;
      };
    };
  };
  programs.git = {
    enable = true;
    config.safe.directory = "/home/moritz/.dotfiles";
  };
}
