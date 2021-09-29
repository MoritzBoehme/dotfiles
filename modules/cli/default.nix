{ config, lib, pkgs, ... }:

{
  imports = [ ./git.nix ./nix.nix ./zsh.nix ];
  programs.adb.enable = true;
  users.users.moritz.extraGroups = [ "adbusers" ];
}
