{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.editors;
in {
  options.modules.editors = {
    vim = mkOption {
      default = true;
      type = types.bool;
      example = false;
    };
  };
  config = mkIf cfg.vim {
    home-manager.users.moritz.programs.neovim = {
      enable = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        (nvim-treesitter.withPlugins (p: pkgs.tree-sitter.allGrammars))
        coc-nvim
        dracula-vim
      ];
      withNodeJs = true;
      withPython3 = true;
    };
  };
}
