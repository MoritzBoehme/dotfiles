{ config, lib, pkgs, ... }:

{
  imports = [ ./emacs.nix ./idea.nix ./vim.nix ./vscode.nix ];
}
