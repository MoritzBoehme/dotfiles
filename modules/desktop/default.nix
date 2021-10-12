{ config, lib, pkgs, ... }:

{
  imports = [ ./bspwm ./polybar ./gtk.nix ];
  home-manager.users.moritz = { services.unclutter.enable = true; };
}
