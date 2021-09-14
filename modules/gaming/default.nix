{ config, lib, pkgs, ... }:

{
  hardware.opengl.enable = true;
  home-manager.users.moritz = {
    home.packages = with pkgs; [
      steam
    ];
  };
}
