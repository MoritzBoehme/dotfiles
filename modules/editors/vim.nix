{ config, lib, pkgs, ... }:

let cfg = config.modules.editors;
in {
  config = lib.mkIf cfg.vim {
    home-manager.users.moritz.programs.neovim = {
      enable = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
