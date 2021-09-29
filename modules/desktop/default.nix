{ config, lib, pkgs, ... }:

{
  imports = [ ./bspwm ./polybar ];
  home-manager.users.moritz = { services.unclutter.enable = true; };
}
