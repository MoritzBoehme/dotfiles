{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {
    home.packages = with pkgs; [ jdk jetbrains.idea-ultimate ];
  };
}
