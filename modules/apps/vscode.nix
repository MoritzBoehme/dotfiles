{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode-fhs;
      extensions = with pkgs;
        [
          vscode-extensions.vscodevim.vim
          vscode-extensions.dracula-theme.theme-dracula
          vscode-extensions.esbenp.prettier-vscode
          vscode-extensions.pkief.material-icon-theme
        ] ++ vscode-utils.extensionsFromVscodeMarketplace [{
          name = "copilot";
          publisher = "GitHub";
          version = "1.7.3689";
          sha256 = "16zrrymxfymc0039zf48vm22rxjs22mh9zkvkpg45grx2a2m19zh";
        }];
    };
  };
}
