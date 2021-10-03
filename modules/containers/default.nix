{ config, lib, pkgs, ... }:

{
  imports = [ ./media.nix ];
  virtualisation.docker.enable = true;
}
