{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {
    programs.git = {
      enable = true;
      userName = "MoritzBoehme";
      userEmail = "mr.x@moritzboeh.me";
      extraConfig.init.defaultBranch = "main";
      delta.enable = true;
    };
  };
}
