{ config, lib, pkgs, inputs, ... }:

let
  base = (home: {
    programs = {
      zsh = {
        enable = true;
        dotDir = ".config/zsh";
        history = { expireDuplicatesFirst = true; };
        shellAliases = {
          ls = "exa -lh";
          cat = "bat";
        };
        plugins = [{
          name = "zsh-syntax-highlighting";
          src = inputs.zsh-syntax-highlighting;
        }];
        enableAutosuggestions = true;
        enableCompletion = true;
      };
      exa.enable = true;
      bat.enable = true;

      starship = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  });
in {
  environment.pathsToLink = [ "/share/zsh" ];
  home-manager.users.moritz = { ... }: (base "/home/moritz");
}
