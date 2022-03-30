{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.editors;
in {
  options.modules.editors = {
    code = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };
  config = mkIf cfg.code {
    home-manager.users.moritz = {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode-fhsWithPackages (ps: with ps; [ git ]);
        extensions = with pkgs.vscode-extensions; [
          bbenoist.nix
          dracula-theme.theme-dracula
          esbenp.prettier-vscode
          github.copilot
          pkgs.nix-flake-tools
          pkief.material-icon-theme
          vscodevim.vim
        ];
      };
    };
  };
}
