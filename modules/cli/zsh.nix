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
          feh = "feh --auto-zoom --scale-down";
        };
        enableSyntaxHighlighting = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        initExtra = ''export DIRENV_LOG_FORMAT=""'';
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
