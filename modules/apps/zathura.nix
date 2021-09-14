{ config, lib, pkgs, ... }:

let
  base = {
    programs.zathura = {
      enable = true;
      options = {
        recolor = true;
        completion-bg = "#282a36";
        completion-fg = "#ff79c6";
        default-bg = "#44475a";
        default-fg = "#bd93f9";
        inputbar-bg = "#282a36";
        inputbar-fg = "#8be9fd";
        statusbar-bg = "#282a36";
        statusbar-fg = "#bd93f9";
        font = "Jetbrains Mono 9";
        recolor-lightcolor = "#282a36";
        recolor-darkcolor = "#f8f8f2";
      };
    };
  };
in
{
  home-manager.users.moritz = { ... }: (base);
}
