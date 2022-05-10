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
        key = "0x970C6E89EB0547A9";
        signByDefault = true;
      };
      lfs.enable = true;
    };
  };
  programs.git = {
    enable = true;
    config.safe.directory = "/home/moritz/.dotfiles";
  };
}
