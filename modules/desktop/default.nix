{ config, lib, pkgs, ... }:

{
  imports = [ ./apps ./bspwm ./polybar ./gtk.nix ];
  home-manager.users.moritz = { services.unclutter.enable = true; };
}
