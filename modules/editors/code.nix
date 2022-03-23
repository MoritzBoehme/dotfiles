{ config, lib, pkgs, ... }:

let cfg = config.modules.editors;
in {
  config = lib.mkIf cfg.code {
    home-manager.users.moritz = {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode-fhsWithPackages (ps: with ps; [ git ]);
        extensions = with pkgs.vscode-extensions;
          [
            vscodevim.vim
            dracula-theme.theme-dracula
            esbenp.prettier-vscode
            pkief.material-icon-theme
          ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
            name = "copilot";
            publisher = "GitHub";
            version = "1.7.3689";
            sha256 = "16zrrymxfymc0039zf48vm22rxjs22mh9zkvkpg45grx2a2m19zh";
          }];
      };
    };
  };
}
