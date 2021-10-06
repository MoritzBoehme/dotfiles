{ config, lib, pkgs, ... }:

{
  programs.adb.enable = true;
  users.users.moritz.extraGroups = [ "adbusers" ];
}
