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
    editor = "emacsclient -t -a 'emacs -t'";
    cmdSub = command:
      "${
        if (config.modules.cli.shell.name == "fish") then "" else "$"
      }${command}";
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
      gf = "git fetch";
      gF = "git pull";
      gs = "git status";
    };
    aliases = {
      ls = "exa -lh --icons --git";
      cat = "bat";
      feh = "feh --auto-zoom --scale-down";
      grep = "rg";
      rm = "rm -i";
      mv = "mv -i";

      ssh = "kitty +kitten ssh";

      nix-switch = "doas nixos-rebuild switch --flake ~/.dotfiles";
      nix-boot = "doas nixos-rebuild boot --flake ~/.dotfiles";
      nix-lock =
        "doas nixos-rebuild dry-activate --flake ~/.dotfiles --recreate-lock-file";

      emacs = editor;

      nixpkgs-review = "nixpkgs-review-checks";

      nixpkgs-pr =
        "nixpkgs-review pr --token ${cmdSub "cat /run/agenix/github"}";

      latexwatch =
        ''find -type f -name "*.tex" | entr -c latexmk -pdf -silent'';

      ledger = "command ledger --strict --explicit";
      bal = "ledger -R bal";
      balcash = "bal -X € --current --flat ^assets:bank ^liabilities";
      balnet = "bal -X € --current --depth 2 ^assets ^liabilities";
      bud = "ledger --budget bal ^expenses";
      budr = ''ledger --budget --real reg -d "d>=[this month]" ^expenses'';
      reg = "ledger reg -R --tail 15";
    };
    variables = {
      EDITOR = editor;
      LEDGER_FILE = "/home/moritz/Notes/ledger/main.ledger";
    };
  };
  home-manager.users.moritz = {
    home.packages = with pkgs; [
      # archives
      p7zip
      unzip

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
      duf
      up
      viu
      entr
      tmux

      arduino

      # nix
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
