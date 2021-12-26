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
      extraConfig = ''
        foreground            #f8f8f2
        background            #282a36
        #background            #000000
        selection_foreground  #44475a
        selection_background  #f8f8f2

        url_color #ffb86c

        # black
        color0  #21222c
        color8  #6272a4

        # red
        color1  #ff5555
        color9  #ff6e6e

        # green
        color2  #50fa7b
        color10 #69ff94

        # yellow
        color3  #f1fa8c
        color11 #ffffa5

        # blue
        color4  #bd93f9
        color12 #d6acff

        # magenta
        color5  #ff79c6
        color13 #ff92df

        # cyan
        color6  #8be9fd
        color14 #a4ffff

        # white
        color7  #f8f8f2
        color15 #ffffff

        # Cursor colors
        cursor            #6272a4
        cursor_text_color background

        # Tab bar colors
        active_tab_foreground   #44475a
        active_tab_background   #f8f8f2
        inactive_tab_foreground #282a36
        inactive_tab_background #6272a4
      '';
      font = {
        name = "FiraCode Nerd Font";
        size = 10;
      };
    };
  };
}
