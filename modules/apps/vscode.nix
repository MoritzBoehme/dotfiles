{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium-fhsWithPackages (ps: with ps; [ git ]);
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        dracula-theme.theme-dracula
        esbenp.prettier-vscode
        pkief.material-icon-theme
      ];
    };
  };
}
