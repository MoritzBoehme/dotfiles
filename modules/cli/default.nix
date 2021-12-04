{ config, lib, pkgs, ... }:

{
  imports = [ ./adb.nix ./direnv.nix ./git.nix ./nix.nix ./zsh.nix ];
  home-manager.users.moritz = {
    home.packages = with pkgs; [
      # archives
      p7zip

      # file manager
      ranger

      trash-cli

      # fetcher
      neofetch
    ];
    programs = {
      exa.enable = true;
      bat.enable = true;
    };
  };
}
