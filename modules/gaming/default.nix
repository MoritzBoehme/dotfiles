{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {
    home.packages = with pkgs; [
      steam
    ];
  };
}
