{ config, lib, pkgs, ... }:

let
  base = (home: {
    programs.git = {
      enable = true;
      userName = "MoritzBoehme";
      userEmail = "mr.x@moritzboeh.me";
      extraConfig = { init.defaultBranch = "main"; };
    };
  });
in { home-manager.users.moritz = { ... }: (base "/home/moritz"); }
