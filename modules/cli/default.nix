{ config, lib, pkgs, ... }:

{
  imports = [
    ./adb.nix
    ./bin
    ./direnv.nix
    ./git.nix
    ./nix.nix
    ./ssh.nix
    ./shell
    ./spotify.nix
    ./yubikey.nix
  ];
  modules.cli.shell = let
    # HACK to fix 24bit color support with kitty
    editor = "TERM=kitty-direct emacsclient -t -a 'emacs -t'";
  in {
    name = "fish";
    abbreviations = {
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
    };
    aliases = {
      ls = "exa -lh --icons --git";
      cat = "bat";
      feh = "feh --auto-zoom --scale-down";
      grep = "rg";
      rm = "rm -i";
      mv = "mv -i";

      # HACK to fix kitty not being recongized
      ssh = "TERM=xterm-color command ssh";

      nix-switch = "doas nixos-rebuild switch --flake ~/.dotfiles";
      nix-boot = "doas nixos-rebuild boot --flake ~/.dotfiles";
      nix-lock =
        "doas nixos-rebuild dry-activate --flake ~/.dotfiles --recreate-lock-file";

      emacs = editor;

      nixpkgs-review = "nixpkgs-review-checks";

      nixpkgs-pr = "nixpkgs-review pr --token ${
          if (config.modules.cli.shell.name == "fish") then "" else "$"
        }(cat /run/agenix/github)";
    };
    variables = { EDITOR = editor; };
  };
  home-manager.users.moritz = {
    home.packages = with pkgs; [
      # archives
      p7zip

      # file management
      ranger
      trash-cli

      # monitoring
      htop
      bottom

      # fetcher
      neofetch

      # typing
      ttyper

      # ripping
      abcde
      handbrake

      # utility
      cht-sh
      du-dust
      arduino
      nixpkgs-review
      comma
      nix-index
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
  age.secrets = {
    github = {
      file = ../../secrets/github.age;
      owner = "1000";
    };
  };
}
