{ config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./podman.nix
    ./virtualisation.nix
  ];
}
