{ config, lib, pkgs, ... }:

{
  home-manager.user.moritz = {
    home.packages = [
      pkgs.buildFHSUserEnv
      {
        name = "Intellij Idea";
        targetPkgs = pkgs: [ pkgs.jetbrains.idea-ultimate pkgs.jdk ];
      }
    ];
  };
}
