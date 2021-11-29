{ config, lib, pkgs, ... }:

{
  imports = [ ./adb.nix ./direnv.nix ./git.nix ./nix.nix ./zsh.nix ];
  home-manager.users.moritz.home.packages = with pkgs; [ p7zip ];
}
