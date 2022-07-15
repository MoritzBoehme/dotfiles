{ config, lib, pkgs, ... }:

with lib;

let cfg = config.our.programs.git;
in {
  options.our.programs.git = {
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
    home-manager.users.moritz = {
      programs.git = {
        enable = true;
        userName = "Moritz Böhme";
        userEmail = "mail@moritzboeh.me";
        extraConfig.init.defaultBranch = "main";
        delta.enable = true;
        signing = mkif cfg.signing {
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
