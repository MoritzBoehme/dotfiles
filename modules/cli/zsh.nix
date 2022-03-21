{ config, lib, pkgs, inputs, ... }:

{
  environment.pathsToLink = [ "/share/zsh" ];
  users.users.moritz.shell = pkgs.zsh;
  home-manager.users.moritz = {
    home.packages = with pkgs; [ du-dust ];
    programs = {
      zsh = {
        enable = true;
        dotDir = ".config/zsh";
        history.expireDuplicatesFirst = true;
        localVariables = { EDITOR = "emacsclient -nw"; };
        shellAliases = {
          du = "dust";
          ls = "exa -lh --icons --git";
          cat = "bat";
          feh = "feh --auto-zoom --scale-down";
          grep = "rg";

          us = "systemctl --user";
          rs = "doas systemctl";

          ga = "git add";
          gb = "git branch";
          gc = "git commit";
          gco = "git checkout";
          gd = "git diff";
          gds = "git diff --staged";
          gp = "git push";
          gs = "git status";

          ssh = "TERM=xterm-color ssh";

          nix-switch = "doas nixos-rebuild switch --flake ~/.dotfiles";
          nix-boot = "doas nixos-rebuild boot --flake ~/.dotfiles";
          nix-lock =
            "doas nixos-rebuild dry-activate --flake ~/.dotfiles --recreate-lock-file";
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
      fzfe.enableZshIntegration = true;
      starship.enableZshIntegration = true;
    };
  };
}
