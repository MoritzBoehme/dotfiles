{ config, lib, pkgs, ... }:

{
  imports = [
   ./git.nix
   ./nix.nix
   ./zsh.nix
  ];
}
