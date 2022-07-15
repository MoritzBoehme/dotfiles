{ config, lib, pkgs, ... }:

with lib;

let cfg = config.our.programs.vim;
in {
  options.our.programs.vim = {
    enable = mkOption {
      default = true;
      type = types.bool;
      example = false;
    };
  };
  config = mkIf cfg.enable {
    home-manager.users.moritz.programs.neovim = {
      enable = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
    };
  };
}
