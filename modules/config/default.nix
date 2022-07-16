{ config
, lib
, pkgs
, ...
}:

{
  imports = [
    ./theming.nix
    ./nix.nix
    ./bin
    ./shell.nix
    ./yubikey.nix
    ./email.nix
    ./wallpapers.nix
  ];
}
