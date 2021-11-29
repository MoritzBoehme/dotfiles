{ config, lib, pkgs, inputs, ... }:

{
  environment.pathsToLink = [ "/share/zsh" ];
  home-manager.users.moritz = {
    shell = pkgs.zsh;
    home.packages = with pkgs; [ du-dust ];
    programs = {
      zsh = {
        enable = true;
        dotDir = ".config/zsh";
        history = { expireDuplicatesFirst = true; };
        shellAliases = {
          du = "dust";
          ls = "exa -lh";
          cat = "bat";
          feh = "feh --auto-zoom --scale-down";

          us = "systemctl --user";
          rs = "sudo systemctl";
        };
        enableSyntaxHighlighting = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        initExtra = ''
          function nix-which() {
                   readlink -f $(which $1)
          }
        '';
        plugins = [{
          name = "forgit";
          src = inputs.forgit-git;
        }];
      };
      exa.enable = true;
      bat.enable = true;
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      starship = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
