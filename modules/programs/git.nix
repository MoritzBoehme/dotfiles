{ config
, lib
, pkgs
, ...
}:

with lib;
let
  cfg = config.my.programs.git;
in
{
  options.my.programs.git = {
    enable = mkOption {
      default = true;
      type = types.bool;
      example = false;
    };
    signing = mkOption {
      default = false;
      type = types.bool;
      example = true;
    };
  };

  config = mkIf cfg.enable {
    my.shell.abbreviations = {
      ga = "git add";
      gb = "git branch";
      gc = "git commit";
      gco = "git checkout";
      gd = "git diff";
      gds = "git diff --staged";
      gp = "git push";
      gf = "git fetch";
      gF = "git pull";
      gs = "git status";
    };
    home-manager.users.moritz = {
      programs.git = {
        enable = true;
        userName = "Moritz Böhme";
        userEmail = "mail@moritzboeh.me";
        extraConfig.init.defaultBranch = "main";
        delta.enable = true;
        signing = mkIf cfg.signing {
          key = "0x970C6E89EB0547A9";
          signByDefault = true;
        };
        lfs.enable = true;
      };
    };
    programs.git = {
      enable = true;
      config.safe.directory = "/home/moritz/.dotfiles";
    };
  };
}
