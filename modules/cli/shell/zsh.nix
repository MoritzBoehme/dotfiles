{ config, lib, pkgs, inputs, ... }:

let cfg = config.modules.cli.shell;
in {
  config = lib.mkIf (cfg.name == "zsh") {
    environment.pathsToLink = [ "/share/zsh" ];
    users.users.moritz.shell = pkgs.zsh;
    home-manager.users.moritz = {
      home.packages = with pkgs; [ du-dust ];
      programs = {
        zsh = {
          enable = true;
          dotDir = ".config/zsh";
          history.expireDuplicatesFirst = true;
          localVariables = cfg.variables;
          shellAliases = lib.trivial.mergeAttrs cfg.aliases cfg.abbreviations;
          enableSyntaxHighlighting = true;
          enableAutosuggestions = true;
          enableCompletion = true;
          initExtra = ''
            function nix-which() {
                     readlink -f $(which $1)
            }
          '';
          plugins = [{
            name = "forgit";
            src = inputs.forgit-git;
          }];
        };
        fzf.enableZshIntegration = true;
        starship.enableZshIntegration = true;
      };
    };
  };
}
