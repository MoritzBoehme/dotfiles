{ config, lib, pkgs, ... }:

{
  nix.package = pkgs.nixFlakes;
}
