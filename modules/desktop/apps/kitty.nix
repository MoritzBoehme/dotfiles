{ config, lib, pkgs, ... }:

{
  home-manager.users.moritz = {
    programs.kitty = {
      enable = true;
      settings = {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        cursor_shape = "underline";
        window_padding_width = 3;
      };
      keybindings = {
        "ctrl+plus" = "change_font_size all +2.0";
        "ctrl+minus" = "change_font_size all -2.0";
      };
      font = {
        name = "FiraCode Nerd Font";
        size = 10;
      };
    };
  };
}
