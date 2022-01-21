{ config, lib, pkgs, ... }:

{
  imports = [ ./apps ./bspwm ./polybar ./gtk.nix ];
  home-manager.users.moritz = { services.unclutter.enable = true; };
  # Remap capslock to esc and shift + capslock to capslock
  services.xserver.xkbOptions =
    "terminate:ctrl_alt_bksp,caps:escape_shifted_capslock";
}
