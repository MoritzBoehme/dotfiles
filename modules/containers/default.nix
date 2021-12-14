{ config, lib, pkgs, ... }:

{
  # imports = [ ./media.nix ];
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
}
