{ config, lib, pkgs, ... }:

{
  imports = [
    ./adb.nix
    ./code.nix
    ./direnv.nix
    ./emacs.nix
    ./git.nix
    ./ledger
    ./spotify.nix
    ./vim.nix
    ./nix
  ];
}
