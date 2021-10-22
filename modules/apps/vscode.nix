{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium-fhs;
      extensions = with pkgs; [
        vscode-extensions.vscodevim.vim
        vscode-extensions.dracula-theme.theme-dracula
      ];
    };
  };
}
