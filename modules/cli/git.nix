{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {
    programs.git = {
      enable = true;
      userName = "MoritzBoehme";
      userEmail = "mr.x@moritzboeh.me";
      extraConfig.init.defaultBranch = "main";
      delta.enable = true;
      signing = {
        key = "0x0498CF2DD8CFC6AA";
        signByDefault = true;
      };
    };
  };
}
