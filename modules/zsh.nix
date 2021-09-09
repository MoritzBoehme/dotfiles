{ config, lib, pkgs, ... }:

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
                      src = pkgs.fetchFromGitHub {
                        owner = "zsh-users";
                        repo = "zsh-autosuggestions";
                        rev = "v0.4.0";
                        sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
                      };
                    }
                    {
                      name = "zsh-syntax-highlighting";
                      src = pkgs.fetchFromGitHub {
                        owner = "zsh-users";
                        repo = "zsh-syntax-highlighting";
                        rev = "0e1bb14452e3fc66dcc81531212e1061e02c1a61";
                        sha256 = "09ncmyqlk9a3h470z0wgbkrznb5zyc9dj96011wm89rdxc1irxk2";
                      };
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
