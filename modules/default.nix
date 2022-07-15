{ config, lib, pkgs, ... }:

{
  imports = [
    ./cli
    ./config
    ./config
    ./desktop
    ./editors
    ./gaming.nix
    ./security
    ./services
  ];
}
