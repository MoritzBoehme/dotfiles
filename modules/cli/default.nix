{ config, lib, pkgs, ... }:

{
  imports =
    [ ./bin ./adb.nix ./direnv.nix ./git.nix ./nix.nix ./ssh.nix ./zsh.nix ];
  home-manager.users.moritz = {
    home.packages = with pkgs; [
      # archives
      p7zip

      # file management
      ranger
      trash-cli

      # fetcher
      neofetch

      # typing
      ttyper

      # ripping
      abcde
      handbrake
    ];
    programs = {
      exa.enable = true;
      bat.enable = true;
      gpg.enable = true;
    };
  };
}
