{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz.programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
