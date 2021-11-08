{ config, lib, pkgs, ... }:

{
  imports = [ ./vim.nix ./emacs.nix ./vscode.nix ];
}
