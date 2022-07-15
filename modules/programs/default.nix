{ config
, lib
, pkgs
, ...
}:

{
  imports = [
    ./adb.nix
    ./bspwm
    ./code.nix
    ./direnv.nix
    ./emacs.nix
    ./firefox.nix
    ./fish.nix
    ./git.nix
    ./gpg.nix
    ./hub.nix
    ./kitty.nix
    ./ledger
    ./rofi
    ./spotify.nix
    ./sway.nix
    ./thunar.nix
    ./vim.nix
    ./xmonad
    ./zathura.nix
    ./zsh.nix
  ];
}
