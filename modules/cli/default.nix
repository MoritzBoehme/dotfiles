{ config, lib, pkgs, ... }:

{
  imports = [
    ./adb.nix
    ./bin
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./nix.nix
    ./ssh.nix
    # ./zsh.nix
  ];
  home-manager.users.moritz = {
    home.packages = with pkgs; [
      # archives
      p7zip

      # file management
      ranger
      trash-cli

      # monitoring
      htop

      # fetcher
      neofetch

      # typing
      ttyper

      # ripping
      abcde
      handbrake

      # utility
      cht-sh
    ];
    programs = {
      bat.enable = true;
      command-not-found.enable = true;
      exa.enable = true;
      fzf.enable = true;
      gpg.enable = true;
      starship.enable = true;
    };
  };
}
