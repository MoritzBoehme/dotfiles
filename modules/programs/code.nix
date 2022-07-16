{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.programs.code;
in
{
  options.my.programs.code = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };
  config = mkIf cfg.enable {
    home-manager.users.moritz = {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode-fhsWithPackages (ps: with ps; [ git ]);
        extensions = with pkgs.vscode-extensions; [
          bbenoist.nix
          dracula-theme.theme-dracula
          esbenp.prettier-vscode
          pkief.material-icon-theme
          vscodevim.vim
        ];
      };
    };
  };
}
