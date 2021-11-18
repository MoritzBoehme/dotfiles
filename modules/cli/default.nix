{ config, lib, pkgs, ... }:

{
  imports = [ ./adb.nix ./direnv.nix ./git.nix ./gpg.nix ./nix.nix ./zsh.nix ];
}
