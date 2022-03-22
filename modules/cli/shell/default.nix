{ config, lib, pkgs, ... }:

with lib;
let cfg = config.module.cli.shell;
in {
  options.modules.cli.shell = {
    name = mkOption {
      default = "fish";
      type = types.enum [ "fish" "zsh" ];
      example = "zsh";
    };
    abbreviations = mkOption {
      default = { };
      type = with types; attrsOf str;
      example = { gs = "git status"; };
    };
    aliases = mkOption {
      default = { };
      type = with types; attrsOf (nullOr (either str path));
    };
    variables = mkOption {
      default = { };
      type = with types; attrsOf str;
    };
  };

  imports = [ ./fish.nix ./zsh.nix ];
}
