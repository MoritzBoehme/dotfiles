{ config
, lib
, pkgs
, inputs
, ...
}:

with lib;
let
  cfg = config.my.programs.zsh;
  shellConfig = config.my.shell;
in
{
  options.my.programs.zsh = {
    enable = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.pathsToLink = [ "/share/zsh" ];
    users.users.moritz.shell = pkgs.zsh;
    home-manager.users.moritz.programs = {
      zsh = {
        enable = true;
        dotDir = ".config/zsh";
        history.expireDuplicatesFirst = true;
        localVariables = shellConfig.variables;
        shellAliases = lib.trivial.mergeAttrs shellConfig.aliases shellConfig.abbreviations;
        enableSyntaxHighlighting = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        initExtra = ''
          function nix-which() {
                   readlink -f $(which $1)
          }
        '';
        plugins = [
          {
            name = "forgit";
            src = inputs.forgit-git;
          }
        ];
      };
    };
  };
}
