{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.shell;
in
{
  options.my.shell = {
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
}
