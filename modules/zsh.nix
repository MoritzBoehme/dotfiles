{ config, lib, pkgs, inputs, ... }:

let
  base = (home: {
    programs = {
      zsh = {
        enable = true;
        dotDir = ".config/zsh";
        history = {
          expireDuplicatesFirst = true;
        };
        shellGlobalAliases = {
          ls = "exa -lh";
          cat = "bat";
        };
        plugins = [
                    {
                      name = "zsh-autosuggestions";
                      src = inputs.zsh-autosuggestions;
                    }
                    {
                      name = "zsh-syntax-highlighting";
                      src = inputs.zsh-syntax-highlighting;
                    }
        ];
      };
      exa.enable = true;
      bat.enable = true;

      starship = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  });
in
{
  home-manager.users.moritz = {...}: (base "/home/moritz");
}
