{ config, lib, pkgs, ... }:

{
  imports = [ ./bin ./adb.nix ./direnv.nix ./git.nix ./nix.nix ./zsh.nix ];
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
    ];
    programs = {
      exa.enable = true;
      bat.enable = true;
    };
  };
}
